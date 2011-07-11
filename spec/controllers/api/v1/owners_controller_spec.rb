require 'spec_helper'

describe Api::V1::OwnersController do
  context "create" do
    it "with app" do
      @app = Factory(:app)
      post :save,
           :owner => {:name => 'richard', :email => 'richard@kittypad.com', :password => 'password'},
           :player => {:device_identifier => 'device-identifier', :language => 'cn', :name => 'player', :gender => 0, :time_between_pause => 10, :pause_duration => 20, :time_between_breaks => 30, :break_duration => 40, :time_to_pause => 50, :time_to_break => 60, :weekday_time => 70, :weekend_time => 80},
           :key => @app.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      owner = Owner.last
      owner.name.should == 'richard'
      owner.email.should == 'richard@kittypad.com'

      player = Player.last
      player.device_identifier.should == 'device-identifier'
      player.language.should == 'cn'
      player.name.should == 'player'
      player.gender.should == 0
      player.time_between_pause.should == 10
      player.pause_duration.should == 20
      player.time_between_breaks.should == 30
      player.break_duration.should == 40
      player.time_to_pause.should == 50
      player.time_to_break.should == 60
      player.weekday_time.should == 70
      player.weekend_time.should == 80

      PlayerApp.find_by_player_id_and_app_id(player.id, @app.id).should_not be_nil
    end
  end

  context "update" do
    before :each do
      @owner = Factory(:owner, :email => 'richard@kittypad.com')
      @player = Factory(:player, :owner => @owner, :device_identifier => 'player_device_identifier')
      @app = Factory(:app)
    end

    it "with player" do
      post :save,
           :owner => {:email => 'richard@kittypad.com', :password => 'password'},
           :player => {:device_identifier => 'player_device_identifier', :language => 'cn', :name => 'player', :gender => 0, :time_between_pause => 10, :pause_duration => 20, :time_between_breaks => 30, :break_duration => 40, :time_to_pause => 50, :time_to_break => 60, :weekday_time => 70, :weekend_time => 80},
           :key => @app.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      @player.reload
      @player.device_identifier.should == 'player_device_identifier'
      @player.language.should == 'cn'
      @player.name.should == 'player'
      @player.gender.should == 0
      @player.time_between_pause.should == 10
      @player.pause_duration.should == 20
      @player.time_between_breaks.should == 30
      @player.break_duration.should == 40
      @player.time_to_pause.should == 50
      @player.time_to_break.should == 60
      @player.weekday_time.should == 70
      @player.weekend_time.should == 80

      PlayerApp.find_by_player_id_and_app_id(@player.id, @app.id).should_not be_nil
    end

    it "without player" do
      post :save,
           :owner => {:email => 'richard@kittypad.com', :password => 'password'},
           :player => {:device_identifier => 'device-identifier', :language => 'cn', :name => 'player', :gender => 0, :time_between_pause => 10, :pause_duration => 20, :time_between_breaks => 30, :break_duration => 40, :time_to_pause => 50, :time_to_break => 60, :weekday_time => 70, :weekend_time => 80},
           :key => @app.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      player = Player.last
      player.device_identifier.should == 'device-identifier'
      player.language.should == 'cn'
      player.name.should == 'player'
      player.gender.should == 0
      player.time_between_pause.should == 10
      player.pause_duration.should == 20
      player.time_between_breaks.should == 30
      player.break_duration.should == 40
      player.time_to_pause.should == 50
      player.time_to_break.should == 60
      player.weekday_time.should == 70
      player.weekend_time.should == 80

      PlayerApp.find_by_player_id_and_app_id(player.id, @app.id).should_not be_nil
    end

    it "failure with wrong password" do
      post :save,
           :owner => {:email => 'richard@kittypad.com', :password => 'wrongpassword'},
           :player => {:device_identifier => 'device-identifier', :language => 'cn', :name => 'player', :gender => 0, :time_between_pause => 10, :pause_duration => 20, :time_between_breaks => 30, :break_duration => 40, :time_to_pause => 50, :time_to_break => 60, :weekday_time => 70, :weekend_time => 80},
           :key => @app.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ['wrong email and password']
    end
  end

  context "sync" do
    it "with device_identifier" do
      @player = Factory(:player, :device_identifier => 'device-identifier')
      @owner = @player.owner
      get :sync, :device_identifier => 'device-identifier', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      owner = json_response['owner']
      owner['name'].should == @owner.name
      owner['email'].should == @owner.email

      player = json_response['player']
      player['device_identifier'].should == @player.device_identifier
      player['language'].should == @player.language
      player['name'].should == @player.name
      player['gender'].should == @player.gender
      player['time_between_pause'].should == @player.time_between_pause
      player['pause_duration'].should == @player.pause_duration
      player['time_between_breaks'].should == @player.time_between_breaks
      player['break_duration'].should == @player.break_duration
      player['time_to_pause'].should == @player.time_to_pause
      player['time_to_break'].should == @player.time_to_break
      player['weekday_time'].should == @player.weekday_time
      player['weekend_time'].should == @player.weekend_time
    end
  end
end
