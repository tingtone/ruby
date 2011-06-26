class Api::V1::ScoreTrackersController < Api::V1::BaseController
  before_filter :child_required

  def create
    score_tracker = current_child.score_trackers.build(:score => params[:score], :category_id => params[:category_id], :client_application => current_client_application)
    if score_tracker.save
      if score_tracker.upgrade
        render :json => {:error => false, :messages => ["good job, you got #{Bonus::TIME} minutes more game time each day."]}
      else
        render :json => {:error => false}
      end
    else
      render :json => {:error => true, :messages => score_tracker.errors.full_messages}
    end
  end
end
