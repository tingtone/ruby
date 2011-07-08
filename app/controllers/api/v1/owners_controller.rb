class Api::V1::OwnersController < Api::BaseController
  def save
    @owner = Owner.find_by_email(params[:owner][:email])
    if @owner
      update
    else
      create
    end
  end

  def create
    @owner = Owner.new(params[:owner].merge(:password_confirmation => params[:owner][:password]))
    if @owner.save
      @owner.players.create(params[:player])
      render :json => {:error => false}
    else
      render :json => {:error => true, :messages => @owner.errors.full_messages}
    end
  end

  def update
    if @owner.update_attributes(params[:owner])
      @player = @owner.players.find_by_device_identifier(params[:player][:device_identifer])
      @player.update_attributes(params[:player])
      render :json => {:error => false}
    else
      render :json => {:error => true, :messages => @owner.errors.full_messages}
    end
  end
end
