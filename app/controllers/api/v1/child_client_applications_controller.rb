class Api::V1::ChildClientApplicationsController < Api::V1::BaseController
  before_filter :child_required

  def create
    child_client_application = current_child.child_client_applications.create(:time => params[:time], :client_application => current_client_application)
    if child_client_application.save
      render :json => {:error => false}
    else
      render :json => {:error => true}
    end
  end
end
