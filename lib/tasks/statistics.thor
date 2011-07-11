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
        CategoriesTimePercentWeeks.create(player_id: k[0], category_id: App.find(k[1]).category.id, time: v, total_time: total_time, start_day: start_day, end_day: end_day)
      end
      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end #favorite_apps_week_trackers

end
