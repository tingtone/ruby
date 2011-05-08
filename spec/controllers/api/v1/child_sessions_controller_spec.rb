require 'spec_helper'

describe Api::V1::ChildSessionsController do
  context "sign in" do
    before do
      Factory(:child, :email => 'child@test.com', :password => 'children', :password_confirmation => 'children')
    end

    it "should success" do
      post :create, :email => 'child@test.com', :password => 'children', :format => :json, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      json_response['authentication_token'].should_not be_blank
    end

    it "should fail" do
      post :create, :email => 'child@test.com', :password => 'wrong', :format => :json, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
    end
  end
end
