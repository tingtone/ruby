# Requirements:
#    1.同年龄的小孩子的各个学科的平均等级。每个年龄段，每个App的平均分


class Stats::AppScoreStat < ActiveRecord::Base


  #定义关系类型
  belongs_to :client_application


  def average_score
    #平均每次得分
    self.total_score.to_f / self.total_times
  end

  class << self

    def log(child, app, score)
      #记录 孩子应用程序总使用时间
      #（应用程序，年龄组）标识一条记录
      if child and app
        stats = self.find_or_create(:first, :conditions=>["client_application_id=? and age_group=?", app.id, child.age_group])
        stats.app = app
        stats.app_type = app.type
        stats.total_score += score
        stats.total_times += 1
        stats.age_group = child.age_group
        stats.save!
      end
    end

    def total_app_score(type, page=1, page_size=10)
      #应用程序得分排序
      sorted = "sum_time desc"
      select = "sum(total_score) as total_score,sum(total_times) as total_times,client_application_id"
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