class Analytics::AppStatsController < ApplicationController
  include Analytics::BaseHelper
  layout "analytic"

  def index
    @app_times = Stats::AppStat.total_app_time
    @group_times = Stats::AppStat.group_app_type
    @app_age_times = Stats::AppStat.age_group_time(ClientApplication.first)

    #app_times = column_line("Child Top 5","game_time",show_data,xaxis)
  end

  def show
  end

end
