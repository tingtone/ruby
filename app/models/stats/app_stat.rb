# Requirements:
#    1.educational/other apps 使用时间排序
#    2.average time for each kid to spend on educational games/other games / different age group
#    3.花的时间最多的教育游戏。
#    设计：
#       应用程序使用表
#       字段： app（应用），sum_time（总时间）, app_type（应用类型），total_times(玩这个游戏的次数)，age_group (2+,5+,.......)
#       sum_time /total_times ﻿= 平均时间
#

class Stats::AppStat < ActiveRecord::Base


  #定义关系类型
  belongs_to :client_application


  def average_time
    #平均每次玩多长时间
    self.sum_time.to_f / self.total_times
  end

  class << self

    def log(child, app, time)
      #记录 孩子应用程序总使用时间
      #（应用程序，年龄组）标识一条记录
      if child and app
        stats = self.find_or_create(:first, :conditions=>["client_application_id=? and age_group=?", app.id, child.age_group])
        stats.app = app
        stats.app_type = app.type
        stats.sum_time += time
        stats.total_times += 1
        stats.age_group = child.age_group
        stats.save!
      end
    end

    def total_app_time(type, page=1, page_size=10)
      #应用程序使用时间排序
      sorted = "sum_time desc"
      select = "sum(sum_time) as sum_time,sum(total_times) as total_times,client_application_id"
      conditions = ""
      conditions = ["app_type=?", type] if type
      Stats::AppStat.where(conditions).select(select).group("client_application_id").includes(:client_application).order(sorted).page(page||1).per(page_size)
    end

    def age_group_time(app)
      #某个App 的 Age_Group 排序
      sorted = "age_group"
      Stats::AppStat.where(:client_application=>app).includes(:client_application).order(sorted) if app
    end


  end


end