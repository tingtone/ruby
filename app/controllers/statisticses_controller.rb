class StatisticsesController < ApplicationController
  before_filter :need_loged_in

  def index
    #test data
    if params[:typee] && params[:typee] == 'active_top10'
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
    end
  end #index
  
  private
    def need_loged_in
      unless developer_signed_in? || owner_signed_in?
        redirect_to root_path
      end
    end #need_loged_in
end