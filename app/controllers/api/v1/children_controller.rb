class Api::V1::ChildrenController < Api::V1::BaseController
  before_filter :parent_required

  def create
    child = current_parent.children.build(params[:child])
    if child.save
      render :json => {:error => false, :children => current_parent.children}
    else
      render :json => {:error => true, :messages => child.errors.full_messages}
    end
  end

  def index
    children = current_parent.children
    render :json => {:error => false, :children => children}
  end

  def show
    child = current_parent.children.find(params[:id])
    render :json => {:error => false, :child => child}
  end
end
