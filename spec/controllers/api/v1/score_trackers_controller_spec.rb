require 'spec_helper'

describe Api::V1::ScoreTrackersController do
  context "create" do
    it "success" do
      @math = Factory(:category, :name => 'math')
      @app = Factory(:app, :category => @math)
      @player = Factory(:player)
      post :create, :score => 10, :player_id => @player.id, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      score_tracker = ScoreTracker.last
      score_tracker.app.should == @app
      score_tracker.category.should == @math
      score_tracker.player.should == @player
      score_tracker.score.should == 10
    end
  end
end
