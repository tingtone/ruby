require 'spec_helper'

describe Api::V1::OwnersController do
  context "create" do
    it "with app" do
      post :save,
           :owner => {:name => 'richard', :email => 'richard@kittypad.com', :password => 'testtest'},
           :player => {:device_identifier => 'device-identifier', :language => 'cn', :name => 'player', :gender => 0, :time_between_pause => 10, :pause_duration => 20, :time_between_breaks => 30, :break_duration => 40, :time_to_pause => 50, :time_to_break => 60, :weekday_time => 70, :weekend_time => 80},
           :no_sign => true

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
    end
  end

  context "update" do
    it "with app" do
      owner = Factory(:owner, :email => 'richard@kittypad.com')
      player = Factory(:player, :owner => owner)
      post :save,
           :owner => {:name => 'richard', :email => 'richard@kittypad.com', :password => 'testtest'},
           :player => {:device_identifier => 'device-identifier', :language => 'cn', :name => 'player', :gender => 0, :time_between_pause => 10, :pause_duration => 20, :time_between_breaks => 30, :break_duration => 40, :time_to_pause => 50, :time_to_break => 60, :weekday_time => 70, :weekend_time => 80},
           :no_sign => true

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
    end
  end
end
