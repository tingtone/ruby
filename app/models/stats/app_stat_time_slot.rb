# Requirements:
#    1.educational/other apps 使用时间排序
#    2.average time for each kid to spend on educational games/other games / different age group
#    3.花的时间最多的教育游戏。
#    设计：
#       应用程序使用表
#       字段： app（应用），sum_time（总时间）, app_type（应用类型），total_times(玩这个游戏的次数)，age_group (2+,5+,.......)
#       sum_time /total_times ﻿= 平均时间
#

# t.integer :span
#      t.integer :sum_time,:default=>0
#      t.integer :total_times,:default=>0
#      t.integer :client_application_id
#      t.string :app_type

class Stats::AppStatTimeSlot < ActiveRecord::Base


  #定义关系类型
  belongs_to :client_application

  #常量定义
  DAY = 1
  WEEK = 2
  MONTH = 3

  def average_time
    #平均每次玩多长时间
    self.sum_time.to_f / self.total_times
  end

  class << self

    def log(app, time, span=DAY)
      #记录应用程序总使用时间
      if child and app
        timetag = span2time(span)
        stats = self.find(:first, :conditions=>["client_application_id=? and span=? and timetag=?", app.id, span, timetag])
        if stats.blank?
          stats = Stats::AppStatTimeSlot.new
          stats.client_application = app
          stats.app_type = app.type
          stats.timetag = timetag
          stats.span = span
        end
        stats.sum_time += time
        stats.total_times += 1
        stats.save!
      end
    end

    def app_time(app, span=DAY, page=1, page_size=30)
      #获得应用程序使用时间排序
      Stats::AppStatTimeSlot.where({:client_application=>app,:span=>span}).includes(:client_application).order("timetag desc").page(page||1).per(page_size)
    end

    def app_time_json(app, span=DAY, page=1, page_size=30)
      #这里用于to_json 方法
    end

    private
    def span2time(span)
      case span
        when DAY then
          Time.now.beginning_of_day.to_i
        when WEEK then
          Time.now.beginning_of_week.to_i
        when MONTH then
          Time.now.beginning_of_month.to_i
        else
          Time.now.beginning_of_day.strftime.to_i
      end
    end

  end


end