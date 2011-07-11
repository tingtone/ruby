class StatisticsesController < ApplicationController

  def index
    #test data
    if !params[:typee].blank? && params[:typee] == 'active_top10'
      @active_top10 = HighChart.new('graph') do |f|
        most_actives = MostActive.hot_apps
        app_names = App.find(most_actives.keys).map(&:name)

        f.options[:chart][:defaultSeriesType] = 'column'
        f.options[:title][:text]              = 'Hot Apps Top 10 at yesterday'
        f.options[:x_axis][:categories]       = app_names
        f.options[:x_axis][:labels]           = { :align=>'center' }
        f.options[:y_axis][:title][:text]     = 'Time (minutes)'

        f.series(name: 'Time', data: most_actives.values)
      end
    end
    
    if !params[:device].blank?
      @player = Player.find_by_device_identifier(params[:device])
      
      @categories_time_percent_weeks = HighChart.new('graph') do |f|
        datas = CategoriesTimePercentWeek.time_percent(@player.id)
        
        f.options[:title][:text] = "Time Percent For App Categories Weekly"
        # f.series(type: 'pie', name: 'time percent for app categories weekly', data: datas)
        f.series(type: 'pie', name: 'time percent for app categories weekly', data: [['App', 25], ['Game', 45], ['Education', 23],['Others', 5.5]])
      end
      
      @favorite_apps_week_trackers = HighChart.new('graph') do |f|
        favorite_apps = FavoriteAppsWeekTracker.top3_apps(@player.id)
        app_names = App.find(favorite_apps.keys).map(&:name)
        
        f.options[:title][:text] = 'My faverite Top 3 apps last week'
        f.options[:chart][:defaultSeriesType] = 'column'
        f.options[:x_axis][:categories]       = app_names
        f.options[:x_axis][:labels]           = { :align=>'center' }
        f.options[:y_axis][:title][:text]     = 'Time (minutes)'

        # f.series(name: 'Time', data: favorite_apps.values)
        f.series(name: 'Time', data: [320, 240, 160] )
      end
      
      @install_apps_day_trackers = HighChart.new('graph') do |f|
        install_apps_day_trackers = InstallAppsDayTracker.apps_time(@player.id)
        app_names = App.find(install_apps_day_trackers.keys).map(&:name)
        
        f.options[:title][:text] = 'How much time to spent every app yesterday'
        f.options[:chart][:defaultSeriesType] = 'column'
        f.options[:x_axis][:categories]       = app_names
        f.options[:x_axis][:labels]           = { :align=>'center' }
        f.options[:y_axis][:title][:text]     = 'Time (minutes)'

        # f.series(name: 'Time', data: install_apps_day_trackers.values)
        f.series(name: 'Time', data: [160, 120, 80, 20] )
      end
    end
    
  end #index

end