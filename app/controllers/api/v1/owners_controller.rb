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
      week = Time.at(params[:timestamp].to_i).stamp("Sunday")
      params_day  = Time.at(params[:timestamp].to_i).stamp("1900-01-01")
      db_store_player_stamp = Time.at(@player.timestamp.to_i).stamp("1900-01-01")
      
      result = {:error => false}
      if !params[:timestamp].blank? || params[:timestamp].to_i > @player.owner.timestamp.to_i
        result.merge! :owner => @player.try(:owner)
      end
      if !params[:timestamp].blank? || params[:timestamp].to_i > @player.timestamp.to_i
        if params_day != db_store_player_stamp
          if week == 'Sunday' || week == 'Saturday'
            @player.update_attributes(time_left: @player.weekend_time.to_i)
          else
            @player.update_attributes(time_left: @player.weekday_time.to_i)
          end
        end
        result.merge! :player => @player
        if false # 支付过
          result[:player][:expired_timestamp] = @player.expired_timestamp.to_i
          if false
            result[:player][:is_web_pay] = true
          end #满足条件
        end
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
  
  def ipad
    if !current_player
      access_denied("no such device identifier") 
    else
      if !params[:iap_timestamp].blank?
        @player_app = PlayerApp.find_by_player_id_and_app_id(current_player.id, current_app.id)
        iap_timestamp = params[:iap_timestamp].to_i
        expired_timestamp = (Time.at(iap_timestamp) + 30.day).to_i
        if @player_app.update_attributes(:payment_timestamp => , :payment_method => 'iap' )
          current_player.update_attributes(:expired_timestamp => expired_timestamp)
        end
        render :json => {:error => false}
      else
        render :json => {:error => true, :messages => "IapTime can't be blank!"}
      end
    end
    
  end #ipad
end
