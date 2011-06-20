class Api::V1::ChildrenController < Api::V1::BaseController
  before_filter :parent_required

  def create
    handle_rule_definition_params(params)
    child = current_parent.children.build(params[:child])
    if child.save
      render :json => {:error => false, :child => child}
    else
      render :json => {:error => true, :messages => child.errors.full_messages}
    end
  end

  def update
    handle_rule_definition_params(params)
    child = current_parent.children.find(params[:id])
    if child.update_attributes(params[:child])
      render :json => {:error => false, :child => child}
    else
      render :json => {:error => true, :messages => child.errors.full_messages}
    end
  end

  protected
    def handle_rule_definition_params(params)
      if params[:child][:rule_definitions_attributes]
        params[:child][:rule_definitions_attributes]["2"][:client_application_id] = current_client_application.id
        params[:child][:rule_definitions_attributes]["3"][:client_application_id] = current_client_application.id
      end
    end
end
