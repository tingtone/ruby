class Api::V1::ParentsController < Api::V1::BaseController
  def save
    @parent = Parent.find_by_email(params[:parent][:email])
    if @parent
      update
    else
      create
    end
  end

  def create
    @parent = Parent.new(params[:parent])
    if @parent.save
      @parent.add_device(params[:device][:identifier])
      @parent.add_client_application(current_client_application)
      render :json => {
        :error => false
      }
    else
      render :json => {:error => true, :messages => @parent.errors.full_messages}
    end
  end

  def update
    if @parent.update_attributes(params[:parent])
      @parent.add_device(params[:device][:identifier])
      @parent.add_client_application(current_client_application)
      render :json => {
        :error => false
      }
    else
      render :json => {:error => true, :messages => @parent.errors.full_messages}
    end
  end
end
