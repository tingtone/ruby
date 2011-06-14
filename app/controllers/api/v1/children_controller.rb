class Api::V1::ChildrenController < Api::V1::BaseController
  before_filter :parent_required

  def create
    child = current_parent.children.build(params[:child])
    if child.save
      render :json => {:error => false, :child => {:id => child.id}}
    else
      render :json => {:error => true, :messages => child.errors.full_messages}
    end
  end

  def update
    child = current_parent.children.find(params[:id])
    if child.update_attributes(params[:child])
      render :json => {:error => false}
    else
      render :json => {:error => true, :messages => child.errors.full_messages}
    end
  end
end
