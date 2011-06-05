class Api::V1::ParentsController < Api::V1::BaseController
  def create
    parent = Parent.new(params[:parent])
    if parent.save && parent.devices.create(params[:device])
      parent.add_client_application(current_client_application)
      render :json => {
        :error => false,
        :client_application => {
          :type => current_client_application.type
        },
        :parent => {
          :id => parent.id,
          :authentication_token => parent.authentication_token,
        }
      }
    else
      render :json => {:error => true, :messages => parent.errors.full_messages}
    end
  end
end
