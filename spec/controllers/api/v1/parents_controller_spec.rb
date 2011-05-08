require 'spec_helper'

describe Api::V1::ParentsController do
  context "create a parent" do
    before do
      @client_application = Factory(:client_application)
    end

    it "should success" do
      post :create, :parent => {:email => 'parent@test.com', :password => 'parent', :password_confirmation => 'parent'}, :format => :json, :key => @client_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      Parent.last.client_applications.should be_include(@client_application)
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
