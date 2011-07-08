class MostActive < TopTen
  
  def self.hot_apps
    yestoday = Date.today - 1
    most_actives = where("DATE_FORMAT(updated_at, '%Y-%m-%d') = ?", yestoday.to_s(:db)).order("time desc").limit(10)
    app_ids_times = Hash.new.tap do |h|
      most_actives.each{|ma| h[ma.app_id] = ma.time}
    end
    return app_ids_times
  end #self.hot_apps
end
