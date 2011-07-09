class Api::V1::ScoreTrackersController < Api::BaseController
  before_filter :player_required

  def create
    score_tracker = current_player.score_trackers.build(:score => params[:score], :category => current_app.category, :app => current_app)
    if score_tracker.save
      render :json => {:error => false}
    else
      render :json => {:error => true, :messages => score_tracker.errors.full_messages}
    end
  end
end
