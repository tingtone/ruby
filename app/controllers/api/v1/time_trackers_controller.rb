class Api::V1::TimeTrackersController < Api::V1::BaseController
  before_filter :child_required

  def create
    time_tracker = current_child.time_trackers.build(:time => params[:time], :client_application => current_client_application)
    if time_tracker.save
      render :json => {:error => false}
    else
      render :json => {:error => true}
    end
  end
end
