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
    if !@player
      access_denied("no such device identifier") 
    else
      result = {:error => false}
      if !params[:timestamp].blank? || params[:timestamp].to_i > @player.owner.timestamp.to_i
        result.merge! :owner => @player.try(:owner)
      end
      if !params[:timestamp].blank? || params[:timestamp].to_i > @player.timestamp.to_i
        result.merge! :player => @player
      end
      render :json => result
    end
  end

  def create
    @owner = Owner.new(params[:owner].merge(:password_confirmation => params[:owner][:password]).merge(:timestamp => params[:timestamp]))
    if @owner.save
      @player = @owner.players.create(params[:player].merge(:timestamp => params[:timestamp]))
      @player.add_app(current_app)
      render :json => {:error => false}
    else
      render :json => {:error => true, :messages => @owner.errors.full_messages}
    end
  end

  def update
    unless @owner.valid_password?(params[:owner][:password])
      render :json => {:error => true, :messages => ["wrong email and password"]} and return
    end
    @player = @owner.players.find_by_device_identifier(params[:player][:device_identifier])
    if @player
      @player.update_attributes(params[:player].merge(:timestamp => params[:timestamp]))
    else
      @player = @owner.players.create(params[:player].merge(:timestamp => params[:timestamp]))
    end
    if @player.errors.present?
      render :json => {:error => true, :messages => @owner.errors.full_messages}
    else
      @player.add_app(current_app)
      render :json => {:error => false}
    end
  end
end
