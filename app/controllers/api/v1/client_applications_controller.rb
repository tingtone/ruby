class Api::V1::ClientApplicationsController < Api::V1::BaseController
  def show
    # only for test now
    client_application = ClientApplication.find(params[:id])
    render :json => {:error => false, :client_application => client_application}
  end

  def index
    client_applications = current_parent.client_applications.select(:name)
    render :json => {:error => false, :client_applications => client_applications}
  end
end
