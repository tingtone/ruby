class Api::V1::ClientApplicationsController < Api::V1::BaseController
  def kind
    render :json => {:error => false, :kind => current_client_application.type}
  end
end
