class FavoriteAppsWeekTracker < ActiveRecord::Base
  
  def self.top3_apps(player_id)
    start_day = Date.today - 7
    end_day = Date.today
    
    data = where("DATE_FORMAT(start_day, '%Y-%m-%d') >= ? and DATE_FORMAT(start_day, '%Y-%m-%d') < ? and player_id =?", start_day.to_s(:db), end_day.to_s(:db), player_id).order("total_time desc").limit(3)
    
    app_ids_times = Hash.new.tap do |h|
      data.each{|d| h[d.app_id] = d.total_time}
    end
    return app_ids_times
  end
end