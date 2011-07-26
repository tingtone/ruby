class ActiveStat < ActiveRecord::Base
  def self.active_amount(current_developer)
    # HighChart.new('graph') do |f|
    #       yesterday = Date.yesterday.to_s(:db)
    #       
    #       active_stats = ActiveStat.where("DATE_FORMAT(current_day, '%Y-%m-%d') = ? and user_id = ?", yesterday, current_developer.id)
    #       
    #       datas = Array.new.tap do |arr|
    # 
    #           active_stats.each do |item|
    #             arr << {name: item.current_day, active_amounts: item.active_amount}
    #           end
    # 
    #       end
      
      
      # datas = [{name: 'app1', active_amounts: [0, 0, 0,1, 1, 0, 0]}, {name: 'app2', active_amounts: [1, 0, 2,1, 1, 0, 0]}]
      
      # f.options[:chart][:defaultSeriesType] = 'column'
      #      f.options[:title][:text]              = 'The number of people who install your apps 7 days prior to today.'
      #      f.options[:x_axis][:categories]       = dates
      #      f.options[:x_axis][:labels]           = { :align=>'center' }
      #      f.options[:y_axis][:title][:text]     = 'numbers'
      #      
      #      datas.each do |item|
      #        f.series(name: item[:name], data: item[:active_amounts])
      #      end
      
    # end
  end #self.active_amount
end