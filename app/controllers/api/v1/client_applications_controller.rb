class Api::V1::ClientApplicationsController < Api::V1::BaseController
  def show
    @client_application = ClientApplication.find(params[:id])
    render :json => @client_application
  end
end
