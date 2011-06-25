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
        :time_summary => parent.children.collect { |child| current_client_application.time_summary(child).merge(:child_id => child.id) }
      }
      if params[:timestamp].blank? || params[:timestamp].to_i < parent.updated_at.to_i
        result.deep_merge!({
          :parent => {
            :id => parent.id,
            :authentication_token => parent.authentication_token,
            :global_rule_definitions => RuleDefinition.globals
          }
        })
        if !params[:email] || !params[:password]
          result.deep_merge!({
            :parent => {
              :email => parent.email,
              :client_encrypted_password => parent.client_encrypted_password
            }
          })
        end
      end
      if params[:timestamp].blank? || params[:timestamp].to_i < parent.children_updated_at.to_i
        result.deep_merge!({
          :parent => {
            :children => parent.children
          }
        })
      end
      if params[:timestamp].blank? || params[:timestamp].to_i < parent.rule_definitions_updated_at.to_i
        result.deep_merge!({
          :parent => {
            :rule_definitions => parent.children.collect { |child| RuleDefinition.for_child_client_application(child, current_client_application).merge(:child_id => child.id) }
          }
        })
      end
      if params[:timestamp].blank? || params[:timestamp].to_i < parent.bonus_updated_at.to_i
        result[:bonus] = parent.children.collect { |child| child.bonus }.flatten
      end
      render :json => result
    else
      render :json => {:error => true}
    end
  end
end
