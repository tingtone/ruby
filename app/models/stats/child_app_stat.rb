# Requirements:
#   1.玩游戏的总时间
#   2.玩教育的总时间
#   3.小孩使用的 pattern, 是间隔教育/游戏, 还是如何? (Pie Chart 如何)
#
#   说明：这里时间单位为分钟 integer 类型
#
#   设计：孩子游戏总时间表
#        字段： child（孩子），sum_time（总时间）, total_times（总次数）,app,app_type（app类型）
#
#   平均每次玩多长时间 ＝ sum_time / total_times

class Stats::ChildAppStat < ActiveRecord::Base


  #定义关系类型
  belongs_to :child
  belongs_to :client_application


  def average_time
    #平均每次玩多长时间
    self.sum_time.to_f / self.total_times
  end

  class << self

    def log(child, app, time)
      #记录 孩子应用程序总使用时间
      if child and app
        stats = self.find_or_create(:first, :conditions=>["child_id=? and client_application_id=?", [child.id, app.id]])
        stats.child = child
        stats.app = app
        stats.app_type = app.type
        stats.sum_time += time
        stats.total_times += 1
        stats.save!
      end
    end

    def app_total_time(child)
      # App 游戏总时间
      self.find(:all, :conditions=>["child_id=?", child.id], :includes=>["child", "client_application"]) if child
    end

    def total_time(child)
      # App_type 游戏总时间
      if child
        select = "count(client_application_id) as app_count,sum(sum_time) as sum_time,sum(total_times) as total_times,group_type"
        self.find(:all, :select=>select, :group=>"app_type", :conditions=>["child_id=?", child.id])
      end
    end

  end
end