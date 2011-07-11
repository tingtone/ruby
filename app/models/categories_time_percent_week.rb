class CategoriesTimePercentWeek < ActiveRecord::Base
  
  def self.time_percent(player_id)
    start_day = Date.today - 7
    end_day = Date.today
    #TODO category 重复
    data = where("DATE_FORMAT(start_day, '%Y-%m-%d') >= ? and DATE_FORMAT(start_day, '%Y-%m-%d') < ? and player_id =?", start_day.to_s(:db), end_day.to_s(:db), player_id)
    
    datas = Array.new.tap do |h|
      data.each{|d| h << [Category.find(d.category_id).name, (d.time.to_f/d.total_time.to_f)*100] }
    end
    return datas
  end #self.hot_apps
end