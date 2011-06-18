require 'spec_helper'

describe Api::V1::ParentsController do
  context "create a parent" do
    before do
      @client_application = Factory(:education_application)
    end

    it "should success" do
      post :create, :parent => {:email => 'parent@test.com', :password => 'parent', :password_confirmation => 'parent'}, :device => {:identifier => 'device-identifier'}, :format => :json, :key => @client_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      json_response['client_application']['type'].should == 'EducationApplication'
      json_response['parent']['id'].should_not be_blank
      json_response['parent']['authentication_token'].should_not be_blank

      Parent.last.client_applications.should be_include(@client_application)
      Parent.last.devices.should be_include(Device.last)
      Device.last.identifier.should == 'device-identifier'

      rule_definitions = json_response['parent']['global_rule_definitions']
      rule_definitions['game_day_time'].should == 30
      rule_definitions['game_week_time'].should == 60
      rule_definitions['total_day_time'].should == 120
      rule_definitions['total_week_time'].should == 240
    end

    it "should fail" do
      post :create, :parent => {:email => 'parent@test.com'}, :format => :json, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["Password can't be blank"]
    end
  end
end
