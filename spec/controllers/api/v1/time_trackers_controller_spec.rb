require 'spec_helper'

describe Api::V1::TimeTrackersController do
  context "create" do
    before do
      @app = Factory(:app)
      @player = Factory(:player)
    end

    it "success" do
      post :create, :time => 10, :time_to_pause => 5, :time_to_break => 10, :player_id => @player.id, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      time_tracker = TimeTracker.last
      time_tracker.app.should == @app
      time_tracker.player.should == @player
      time_tracker.time.should == 10

      @player.reload
      @player.time_to_pause.should == 5
      @player.time_to_break.should == 10
    end
  end
end
