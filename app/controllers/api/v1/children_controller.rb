class Api::V1::ChildrenController < Api::V1::BaseController
  def create
    child = current_parent.children.build(params[:child])
    if child.save
      render :json => {:error => false}
    else
      render :json => {:error => true, :messages => child.errors.full_messages}
    end
  end
end
