class CategoriesTimePercentWeek < ActiveRecord::Base
  
  def self.time_percent(player_id)
    start_day = Date.today - 7
    end_day = Date.today
    begin
    datas = where("DATE_FORMAT(start_day, '%Y-%m-%d') >= ? and DATE_FORMAT(start_day, '%Y-%m-%d') < ? and player_id =?", start_day.to_s(:db), end_day.to_s(:db), player_id)
    total_time = datas.first.try(:total_time)
    data = datas.group("category_id").sum(:time)
    
    result = Array.new.tap do |h|
      data.each{|k, v| h << [Category.find(k).name, (v.to_f/total_time.to_f)*100] }
    end
    rescue
      result = []
    end
    return result
  end #self.hot_apps
end