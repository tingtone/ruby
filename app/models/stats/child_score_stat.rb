# Requirements:
#    1.educational/other apps 使用时间排序
#    2.average time for each kid to spend on educational games/other games / different age group
#    3.花的时间最多的教育游戏。
#    设计：
#       应用程序使用表
#       字段： app（应用），sum_time（总时间）, app_type（应用类型），total_times(玩这个游戏的次数)，age_group (2+,5+,.......)
#       sum_time /total_times ﻿= 平均时间
#

class Stats::ChildScoreStat < ActiveRecord::Base

  #常量定义
  WEEK = 1

  #定义关系类型
  belongs_to :child
  belongs_to :client_application

  def average_score
    #平均每次得分
    self.total_score.to_f / self.total_times
  end

  class << self

    def log(child, app, score)
      # 记录 孩子应用程序总使用时间
      #（child , app , span , timetag）标识一条记录
      # 目前默认时间为 timetag
      if child and app
        time_tag = Time.now.beginning_of_week
        stats = self.find_or_create(:first, :conditions=>["child_id=? and client_application_id=? and span=? and timetag=?", \
         [child.id, app.id, WEEK, time_tag]])
        stats.app = app
        stats.app_type = app.type
        stats.child = child
        stats.span = WEEK
        stats.timetag = time_tag
        stats.total_score += score
        stats.total_times += 1
        stats.save!
      end
    end

    def total_app_score(child)
      #所有应用程序score
      if child
        select = "sum(total_score) as total_score,sum(total_times) as total_times,child_id,app_type"
        conditions = ["child_id=?", child.id]
        self.find(:all, :conditions=>conditions, :select=>select, :group=>"child_id,app_type", :includes=>:child)
      end
    end

    def app_score(child, app, page_size=30)
      #某个App 的 score
      if child and app
        sorted = "sum_time desc"
        conditions = ["child_id=? and client_application_id=? and span=?", child.id, app.id, WEEK]
        self.find(:all, :conditions=>conditions, :order=>sorted, :includes=>:child, :limit=>page_size)
      end
    end


  end


end