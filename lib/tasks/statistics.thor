# 
#  statistics.thor
#  ruby
#  
#  Created by zhang alex on 2011-07-08.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 
# 
#  init_administrator.thor
#  ruby
#  
#  Created by Zhang Alex on 2011-06-22.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 
# when run it in production env , need run: export RAILS_ENV=production
# thor -T


class Statistics < Thor
  include Thor::Actions

  desc "most_active", "init most active everyday"
  # method_options :force => true
  def most_active
    require './config/environment'
    begin
      
      result = TimeTracker.where("DATE_FORMAT(updated_at, '%Y-%m-%d') = ?", (Date.today - 1).to_s(:db)).group(:app_id).sum(:time)
      result.each do |k, v|
        MostActive.create(app_id: k, time: v)
      end

      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end
  
  desc "most_score", 'init most score everyday'
  def most_score
    require './config/environment'
    begin

      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end #most_score

  # ========================================================
  # = record total time by played every ipad and everyday  =
  # ========================================================
  desc "install_apps_day_tracker", 'record total time by played every ipad and everyday'
  def install_apps_day_tracker
    require './config/environment'
    begin
      result = TimeTracker.where("DATE_FORMAT(updated_at, '%Y-%m-%d') = ?", (Date.today - 1).to_s(:db)).group(:player_id).group(:app_id).sum(:time)
      # {[1, 1]=>80, [1, 2]=>120, [1, 3]=>160, [1, 4]=>20}
      result.each do |k, v|
        InstallAppsDayTracker.create(player_id: k[0], app_id: k[1], total_time: v)
      end
      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end #install_apps_day_tracker

  # ========================================================
  # = record favorite app for every ipad and everyweek     =
  # ========================================================
  desc "favorite_apps_week_trackers", 'record favorite app for every ipad and everyweek'
  def favorite_apps_week_trackers
    require './config/environment'
    begin
      end_day = Date.today.to_s(:db)
      start_day = (Date.today - 7).to_s(:db)
      result = TimeTracker.where("DATE_FORMAT(updated_at, '%Y-%m-%d') >= ? and DATE_FORMAT(updated_at, '%Y-%m-%d') < ?", start_day, end_day).group(:player_id).group(:app_id).sum(:time)
      result.each do |k, v|
        FavoriteAppsWeekTracker.create(player_id: k[0], app_id: k[1], total_time: v, start_day: start_day, end_day: end_day)
      end
      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end #favorite_apps_week_trackers


  # ========================================================
  # = record time percent for every category and everyweek =
  # ========================================================
  desc "categories_time_percent_weeks", 'record time percent for every category and everyweek'
  def categories_time_percent_weeks
    require './config/environment'
    begin
      end_day = Date.today.to_s(:db)
      start_day = (Date.today - 7).to_s(:db)
      total_time = TimeTracker.where("DATE_FORMAT(updated_at, '%Y-%m-%d') >= ? and DATE_FORMAT(updated_at, '%Y-%m-%d') < ?", start_day, end_day).sum(:time)
      result = TimeTracker.where("DATE_FORMAT(updated_at, '%Y-%m-%d') >= ? and DATE_FORMAT(updated_at, '%Y-%m-%d') < ?", start_day, end_day).group(:player_id).group(:app_id).sum(:time)
      result.each do |k, v|
        CategoriesTimePercentWeek.create(player_id: k[0], category_id: App.find(k[1]).category.id, time: v, total_time: total_time, start_day: start_day, end_day: end_day)
      end
      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end #favorite_apps_week_trackers


  # ===========================
  # = Average Age For my apps =
  # ===========================
  desc "average_age", 'got average age for every apps every day'
  def average_age
    require './config/environment'
    begin
      yesterday = Date.yesterday.to_s(:db)
      
      datas = PlayerApp.where("DATE_FORMAT(updated_at, '%Y-%m-%d') <= ?", yesterday)
      app_ids = datas.map(&:app_id).uniq
      
      app_ids.each do |app_id|
        app = App.find app_id
        players = app.players
        ages = players.inject([]){|sum, player| sum << player.age }
        player_amount = ages.size
        ave_age = (ages.sum/player_amount).to_i

        result = Hash.new.tap do |r|
          developer = app.developer
          r[:user_id] = developer.id
          r[:developer_name] = developer.name
          r[:app_id] = app.id
          r[:app_name] = app.name
          r[:ave_age] = ave_age
          r[:player_amount] = player_amount
        end

        AveAgeStat.create(user_id: result[:user_id], developer_name: result[:developer_name], app_id: result[:app_id], app_name: result[:app_name], ave_age: result[:ave_age], player_amount: result[:player_amount], current_day: yesterday)
      end
      
      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end
  
  # ===========================
  # = Most Gender For my apps =
  # ===========================
  desc "most_gender", 'got most gender for every apps every day'
  def most_gender
    require './config/environment'
    begin
      yesterday = Date.yesterday.to_s(:db)

      datas = PlayerApp.where("DATE_FORMAT(updated_at, '%Y-%m-%d') <= ?", yesterday)
      app_ids = datas.map(&:app_id).uniq
      
      app_ids.each do |app_id|
        app = App.find app_id
        players = app.players
        
        boys = players.inject([]) do |sum, player|
          next if player.gender != 1
          sum << player  if player.gender == 1
        end
        girls = players.inject([]) do |sum, player|
          next if player.gender != 2
          sum << player  if player.gender == 2
        end
        boy_amount, girl_amount = boys.try(:size).to_i, girls.try(:size).to_i

        result = Hash.new.tap do |r|
          developer = app.developer
          r[:user_id] = developer.id
          r[:developer_name] = developer.name
          r[:app_id] = app.id
          r[:app_name] = app.name
          r[:boy_amount] = boy_amount
          r[:girl_amount] = girl_amount
        end
        GenderStat.create(user_id: result[:user_id], developer_name: result[:developer_name], app_id: result[:app_id], app_name: result[:app_name], boy_amount: result[:boy_amount], girl_amount: result[:girl_amount], current_day: yesterday)
      end
      
      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end
  
  # =============================
  # = Active Amount For my apps =
  # =============================
  desc "active_amount", 'got active amount for every apps every day'
  def active_amount
    require './config/environment'
    begin
      yesterday = Date.yesterday.to_s(:db)

      datas = PlayerApp.where("DATE_FORMAT(updated_at, '%Y-%m-%d') <= ?", yesterday)
      app_ids = datas.map(&:app_id).uniq
      
      app_ids.each do |app_id|
        app = App.find app_id
        players = app.players
        
        active_amount = players.try(:size).to_i
        
        result = Hash.new.tap do |r|
          developer = app.developer
          r[:user_id] = developer.id
          r[:developer_name] = developer.name
          r[:app_id] = app.id
          r[:app_name] = app.name
          r[:active_amount] = active_amount
        end
        ActiveStat.create(user_id: result[:user_id], developer_name: result[:developer_name], app_id: result[:app_id], app_name: result[:app_name], active_amount: result[:active_amount], current_day: yesterday)
      end

      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end
  
end
