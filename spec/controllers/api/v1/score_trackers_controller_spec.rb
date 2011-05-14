require 'spec_helper'

describe Api::V1::ScoreTrackersController do
  context "create" do
    before do
      @child = Factory(:child)
      @education_application = Factory(:education_application)
    end

    it "should success" do
      post :create, :score => 100, :child_id => @child.id, :key => @education_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      score_tracker = ScoreTracker.last
      score_tracker.score.should == 100
      score_tracker.child.should == @child
      score_tracker.client_application.should == @education_application
    end

    it "should fail without score" do
      post :create, :child_id => @child.id, :key => @education_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["Score can't be blank", "Score is not a number"]
    end

    it "should fail when score is larger than max score" do
      post :create, :score => EducationApplication::DEFAULT_MAX_SCORE + 1, :child_id => @child.id, :key => @education_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["Score can't add to this child any more"]
    end
  end
end
