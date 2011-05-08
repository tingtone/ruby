require 'spec_helper'

describe Api::V1::ChildrenController do
  context 'create' do
    before do
      @parent = Factory(:parent, :authentication_token => '1234')
    end

    it "should success" do
      post :create, :child => { :email => 'child@test.com', :password => 'children', :password_confirmation => 'children' }, :parent_token => '1234', :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
    end

    it "should fail for validation" do
      post :create, :child => { :email => 'child@test.com', :password => 'child', :password_confirmation => 'child' }, :parent_token => '1234', :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["Password is too short (minimum is 6 characters)"]
    end

    it "should fail for wrong parent_token" do
      post :create, :child => { :email => 'child@test.com', :password => 'child', :password_confirmation => 'child' }, :parent_token => '4321', :format => 'json', :no_sign => true

      response.response_code.should == 401
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["no such authentication token"]
    end
  end
end
