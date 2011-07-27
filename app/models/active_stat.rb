class ActiveStat < ActiveRecord::Base
  def self.active_amount(current_developer)
    HighChart.new('graph') do |f|
      yesterday = Date.yesterday.to_s(:db)
      active_stats = ActiveStat.where("DATE_FORMAT(current_day, '%Y-%m-%d') = ? and user_id = ?", yesterday, current_developer.id)
      
      datas = Hash.new.tap do |h|
        active_stats.each{|i| h[i.app_name] = i.active_amount}
      end
      
      app_names = datas.keys
      f.options[:chart][:defaultSeriesType] = 'column'
      f.options[:title][:text]              = 'The number of people who install your apps to this day.'
      f.options[:x_axis][:categories]       = app_names
      f.options[:x_axis][:labels]           = { :align=>'center' }

      f.series(name: 'App Name', data: datas.values)
      
    end
  end #self.active_amount
end