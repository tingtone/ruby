class AveAgeStat < ActiveRecord::Base
  
  def self.aveage_age(current_developer)
    HighChart.new('graph') do |f|
      yesterday = (Date.today - 7).to_s(:db)
      ave_age_stats = AveAgeStat.where("DATE_FORMAT(current_day, '%Y-%m-%d') >= ? and user_id = ?", yesterday, current_developer.id)
      datas = Array.new.tap do |arr|
        ave_age_stats.each do |item|
          arr << [item.app_name, item.ave_age]
        end
      end
      f.series(type: 'pie', data: datas)
    end
  end #self.aveage_age
  
end