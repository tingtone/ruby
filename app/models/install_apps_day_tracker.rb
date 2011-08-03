class InstallAppsDayTracker < ActiveRecord::Base
  def self.apps_time(player_id)
    yesterday = Date.today - 1
    data = where("DATE_FORMAT(updated_at, '%Y-%m-%d') = ? and player_id =?", yesterday.to_s(:db), player_id).order("total_time desc")
    
    app_ids_times = Hash.new.tap do |h|
      data.each{|d| h[d.app_id] = d.total_time}
    end
    return app_ids_times
  end #self.hot_apps
end