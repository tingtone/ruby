class Api::V1::ParentSessionsController < Api::V1::BaseController
  def create
    device = Device.find_by_identifier(params[:device_identifier])
    if device
      parent = device.parent
      result = true
    elsif
      parent = Parent.find_by_email(params[:email])
      result = parent && parent.valid_password?(params[:password])
    end
    if result
      parent.add_client_application(current_client_application)
      parent.add_device(params[:device_identifier])
      render :json => {
        :error => false,
        :client_application => {
          :type => current_client_application.type
        },
        :parent => {
          :id => parent.id,
          :authentication_token => parent.authentication_token,
          :children => parent.children.collect {
            |child| {:child => child, :time_summary => current_client_application.time_summary(child)}
          }
        }
      }
    else
      render :json => {:error => true}
    end
  end
end
