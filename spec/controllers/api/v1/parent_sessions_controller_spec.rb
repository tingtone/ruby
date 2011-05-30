require 'spec_helper'

describe Api::V1::ParentSessionsController do
  context "sign in" do
    before do
      @client_application = Factory(:game_application)
      @parent = Factory(:parent, :email => 'parent@test.com', :password => 'parent', :password_confirmation => 'parent')
      @child1 = Factory(:child, :parent => @parent)
      @child2 = Factory(:child, :parent => @parent)
      Factory(:time_tracker, :child => @child1, :client_application => @client_application, :time => 50)
      Factory(:time_tracker, :child => @child2, :client_application => @client_application, :time => 100)

      Factory(:rule_definition, :child => @child1, :client_application => @client_application, :time => 600, :period => 'day')
      Factory(:rule_definition, :child => @child1, :client_application => @client_application, :time => 1000, :period => 'week')
      Factory(:rule_definition, :child => @child1, :time => 1600, :period => 'day')
      Factory(:rule_definition, :child => @child1, :time => 2000, :period => 'week')

      Factory(:rule_definition, :child => @child2, :client_application => @client_application, :time => 600, :period => 'day')
      Factory(:rule_definition, :child => @child2, :client_application => @client_application, :time => 1000, :period => 'week')
      Factory(:rule_definition, :child => @child2, :time => 1600, :period => 'day')
      Factory(:rule_definition, :child => @child2, :time => 2000, :period => 'week')
    end

    it "should success" do
      post :create, :email => 'parent@test.com', :password => 'parent', :format => :json, :key => @client_application.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      json_response['client_application']['type'].should == 'GameApplication'
      json_response['parent']['id'].should_not be_blank
      json_response['parent']['authentication_token'].should_not be_blank
      Parent.last.client_applications.should be_include(@client_application)

      children = json_response['parent']['children']
      children.first['child']['id'].should == @child1.id
      children.first['time_summary']['game_day_left_time'].should == 550
      children.first['time_summary']['total_day_left_time'].should == 1550
      children.first['time_summary']['game_week_left_time'].should == 950
      children.first['time_summary']['total_week_left_time'].should == 1950

      children.last['child']['id'].should == @child2.id
      children.last['time_summary']['game_day_left_time'].should == 500
      children.last['time_summary']['total_day_left_time'].should == 1500
      children.last['time_summary']['game_week_left_time'].should == 900
      children.last['time_summary']['total_week_left_time'].should == 1900
    end

    it "should not add new association for parent and existing client_application" do
      @parent.parent_client_applications.create(:client_application => @client_application)
      @parent.should have(1).client_applications
      post :create, :email => 'parent@test.com', :password => 'parent', :format => :json, :key => @client_application.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should be_false
      json_response['parent']['id'].should_not be_blank
      @parent.reload.should have(1).client_applications
    end

    it "should fail" do
      post :create, :email => 'parent@test.com', :password => 'wrong', :format => :json, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
    end
  end
end
