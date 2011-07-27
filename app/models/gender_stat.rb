class GenderStat < ActiveRecord::Base
  def self.most_gender(current_developer)
    HighChart.new('graph') do |f|
      yesterday = Date.yesterday
      gender_stats = GenderStat.where("DATE_FORMAT(current_day, '%Y-%m-%d') = ? and user_id = ?", yesterday, current_developer.id)
      
      f.options[:title][:text]    = 'The gender ratio of people using your application to this day'
      f.options[:subtitle][:text] = 'Inner circle: Boy, outer circle: Girl'
      boy_datas, girl_datas = [], []
      
      gender_stats.each do |item|
        boy_datas << {name: item.app_name, y: item.boy_amount}
        girl_datas << {name: item.app_name, y: item.girl_amount}
      end
      
      f.series(type: 'pie', name: 'boy', size: '45%', innerSize: '20%', data: boy_datas )
      f.series(type: 'pie', name: 'girl', innerSize: '45%', data: girl_datas)
    end

  end #self.most_gender(current_developer)
end