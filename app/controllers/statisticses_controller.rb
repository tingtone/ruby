class StatisticsesController < ApplicationController
  
  def index
    #test data
    @yestoday_most_acitve_top10 = HighChart.new('graph') do |f|
      most_actives = MostActive.hot_apps
      app_names = App.find(most_actives.keys).map(&:name)

      f.options[:chart][:defaultSeriesType] = 'column'
      f.options[:title][:text]              = 'Hot Apps Top 10 at Yestoday'
      f.options[:x_axis][:categories]       = app_names
      f.options[:x_axis][:labels]           = { :align=>'center' }
      f.options[:y_axis][:title][:text]     = 'Time (minutes)'
      
      f.series(name: 'Time', data: most_actives.values)
      
    end
  end #index
end