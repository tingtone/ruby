class Api::V1::ScoreTrackersController < Api::V1::BaseController
  before_filter :child_required

  def create
    score_tracker = current_child.score_trackers.build(:score => params[:score], :client_application => current_client_application)
    if score_tracker.save
      render :json => {:error => false}
    else
      render :json => {:error => true, :messages => score_tracker.errors.full_messages}
    end
  end
end
