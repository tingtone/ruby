require 'spec_helper'

describe Api::V1::ChildrenController do
  before do
    @parent = Factory(:parent, :authentication_token => '1234')
  end

  context 'create' do
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

  context "index" do
    it "should get all children" do
      child1 = Factory(:child, :parent => @parent)
      child2 = Factory(:child, :parent => @parent)
      get :index, :parent_token => '1234', :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      children = json_response['children']
      children.first['child']['email'].should == child1.email
      children.last['child']['email'].should == child2.email
    end
  end
end
