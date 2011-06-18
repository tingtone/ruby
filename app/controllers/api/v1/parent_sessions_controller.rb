class Api::V1::ParentSessionsController < Api::V1::BaseController
  def create
    if params[:email] && params[:password]
      parent = Parent.find_by_email(params[:email])
      result = parent && parent.valid_password?(params[:password])
    else
      if device = Device.find_by_identifier(params[:device_identifier])
        parent = device.parent
        result = true
      else
        result = false
      end
    end
    if result
      parent.add_client_application(current_client_application)
      parent.add_device(params[:device_identifier])
      result = {
        :error => false,
        :parent => {
          :id => parent.id,
          :email => parent.email,
          :client_salt => parent.client_salt,
          :client_encrypted_password => parent.client_encrypted_password,
          :authentication_token => parent.authentication_token,
          :time_summary => parent.children.collect { |child| current_client_application.time_summary(child).merge(:child_id => child.id) }
        }
      }
      result[:parent][:global_rule_definitions] = RuleDefinition.globals
      result[:parent][:children] = parent.children if params[:timestamp].blank? || params[:timestamp].to_i < parent.children_updated_at.to_i
      if params[:timestamp].blank? || params[:timestamp].to_i < parent.rule_definitions_updated_at.to_i
        result[:parent][:rule_definitions] = parent.children.collect { |child| RuleDefinition.for_child_client_application(child, current_client_application).merge(:child_id => child.id) }
      end
      result[:parent][:bonus] = parent.children.collect { |child| child.bonus }.flatten if params[:timestamp].blank? || params[:timestamp].to_i < parent.bonus_updated_at.to_i
      render :json => result
    else
      render :json => {:error => true}
    end
  end
end
