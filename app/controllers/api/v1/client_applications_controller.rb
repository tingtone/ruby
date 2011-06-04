class Api::V1::ClientApplicationsController < Api::V1::BaseController
  before_filter :child_required, :only => :sync

  def sync
    render :json => current_client_application.time_summary(current_child).merge(:error => false)
  end

  def kind
    render :json => {:error => false, :kind => current_client_application.type}
  end
end
