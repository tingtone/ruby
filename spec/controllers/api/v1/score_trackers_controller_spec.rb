require 'spec_helper'

describe Api::V1::ScoreTrackersController do
  context "create" do
    before do
      @child = Factory(:child)
      @english = Factory(:client_application_category, :name => 'english')
      @math = Factory(:client_application_category, :name => 'math')
      @education_application = Factory(:education_application, :client_application_category => @math)
      @level1 = Factory(:grade, :name => 'level1', :min_score => 0, :max_score => 200)
      @level2 = Factory(:grade, :name => 'level2', :min_score => 201, :max_score => 500)
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

      achievement = Achievement.last
      achievement.child.should == @child
      achievement.client_application_category.should == @math
      achievement.grade.should == @level1
      achievement.score.should == 100

      @child.should have(0).bonus
    end

    it "should upgrade grade" do
      @achievement = Factory(:achievement, :client_application_category => @math, :score => 150, :grade => @level1, :child => @child)
      post :create, :score => 100, :child_id => @child.id, :key => @education_application.key, :no_sign => true
      response.should be_ok

      achievement = Achievement.last
      achievement.child.should == @child
      achievement.client_application_category.should == @math
      achievement.grade.should == @level2
      achievement.score.should == 250

      bonus = Bonus.last
      bonus.child.should == @child
      bonus.time.should == 15
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
