require 'spec_helper'

describe Api::V1::ClientApplicationsController do
  context "sync" do
    before do
      @parent = Factory(:parent)
      @child1 = Factory(:child, :parent => @parent)
      @child2 = Factory(:child, :parent => @parent)
      @game_application1 = Factory(:game_application)
      @game_application2 = Factory(:game_application)
      Factory(:time_tracker, :child => @child1, :client_application => @game_application1, :time => 50)
      Factory(:time_tracker, :child => @child1, :client_application => @game_application2, :time => 100)
      Factory(:time_tracker, :child => @child2, :client_application => @game_application1, :time => 150)
      Factory(:time_tracker, :child => @child2, :client_application => @game_application2, :time => 200)

      Factory(:rule_definition, :child => @child1, :client_application => @game_application1, :time => 600, :period => 'day')
      Factory(:rule_definition, :child => @child1, :client_application => @game_application1, :time => 1000, :period => 'week')
      Factory(:rule_definition, :child => @child1, :time => 1600, :period => 'day')
      Factory(:rule_definition, :child => @child1, :time => 2000, :period => 'week')
    end

    it "should get json summary" do
      get :sync, :child_id => @child1.id, :parent_id => @parent.id, :key => @game_application1.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should be_false
      json_response['game_day_left_time'].should == 550
      json_response['game_week_left_time'].should == 950
      json_response['total_day_left_time'].should == 1450
      json_response['total_week_left_time'].should == 1850
    end

    it "should with bonus time" do
      bonus1 = Factory(:bonus, :child => @child1, :time => 15, :created_at => Time.now.ago(20.weeks))
      bonus2 = Factory(:bonus, :child => @child1, :time => 15, :created_at => Time.now.ago(10.weeks))
      bonus3 = Factory(:bonus, :child => @child1, :time => 15, :created_at => Time.now.ago(5.weeks))
      get :sync, :child_id => @child1.id, :parent_id => @parent.id, :key => @game_application1.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should be_false
      json_response['game_day_left_time'].should == 580
      json_response['game_week_left_time'].should == 980
      json_response['total_day_left_time'].should == 1480
      json_response['total_week_left_time'].should == 1880
    end
  end

  context "kind" do
    it "should be GameApplication" do
      @game_application = Factory(:game_application)

      get :kind, :key => @game_application.key, :no_sign => true
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should be_false
      json_response['kind'].should == 'GameApplication'
    end

    it "should be EducationApplication" do
      @education_application = Factory(:education_application)

      get :kind, :key => @education_application.key, :no_sign => true
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should be_false
      json_response['kind'].should == 'EducationApplication'
    end
  end
end
