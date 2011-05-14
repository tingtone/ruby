require 'spec_helper'

describe Api::V1::ScoreTrackersController do
  context "create" do
    before do
      @child = Factory(:child)
      @client_application = Factory(:client_application)
    end

    it "should success" do
      post :create, :score => 100, :child_id => @child.id, :key => @client_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      score_tracker = ScoreTracker.last
      score_tracker.score.should == 100
      score_tracker.child.should == @child
      score_tracker.client_application.should == @client_application
    end

    it "should fail" do
      post :create, :child_id => @child.id, :key => @client_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
    end
  end
end
