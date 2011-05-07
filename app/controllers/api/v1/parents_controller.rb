class Api::V1::ParentsController < Api::V1::BaseController
  def create
    parent = Parent.new(params[:parent])
    if parent.save
      render :json => {:error => false}
    else
      render :json => {:error => true, :messages => parent.errors.full_messages}
    end
  end
end
