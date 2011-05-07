require 'spec_helper'

describe Api::V1::ParentsController do
  context "create a parent" do
    it "should success" do
      post :create, :parent => {:email => 'parent@test.com', :password => 'parent', :password_confirmation => 'parent'}, :format => :json, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
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
