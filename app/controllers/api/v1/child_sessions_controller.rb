class Api::V1::ChildSessionsController < Api::V1::BaseController
  before_filter :parent_required

  def create
    child = current_parent.children.find_by_fullname(params[:fullname])
    if child
      render :json => {:error => false, :child => {:id => child.id}}
    else
      render :json => {:error => true}
    end
  end
end
