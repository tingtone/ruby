class Api::V1::ParentsController < Api::V1::BaseController
  def create
    parent = Parent.new(params[:parent])
    if parent.save && parent.devices.create(params[:device])
      parent.add_client_application(current_client_application)
      render :json => {
        :error => false,
        :parent => {
          :id => parent.id,
          :email => parent.email,
          :client_encrypted_password => parent.client_encrypted_password,
          :authentication_token => parent.authentication_token,
          :global_rule_definitions => RuleDefinition.globals
        }
      }
    else
      render :json => {:error => true, :messages => parent.errors.full_messages}
    end
  end
end
