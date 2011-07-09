class Api::V1::OwnersController < Api::BaseController
  def save
    @owner = Owner.find_by_email(params[:owner][:email])
    if @owner
      update
    else
      create
    end
  end

  def sync
    @player = Player.find_by_device_identifier(params[:device_identifier])
    access_denied("no such device identifier") if !@player

    result = {:error => false}
    if params[:timestamp].blank? || params[:timestamp].to_i < @player.owner.updated_at.to_i
      result.merge! :owner => @player.owner
    end
    if params[:timestamp].blank? || params[:timestamp].to_i < @player.updated_at.to_i
      result.merge! :player => @player
    end
    render :json => result
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
      @player = @owner.players.find_by_device_identifier(params[:player][:device_identifier])
      if @player
        @player.update_attributes(params[:player])
      else
        @owner.players.create(params[:player])
      end
      render :json => {:error => false}
    else
      render :json => {:error => true, :messages => @owner.errors.full_messages}
    end
  end
end
