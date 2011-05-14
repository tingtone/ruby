require 'spec_helper'

describe Api::V1::ParentSessionsController do
  context "sign in" do
    before do
      @client_application = Factory(:client_application)
      @parent = Factory(:parent, :email => 'parent@test.com', :password => 'parent', :password_confirmation => 'parent')
    end

    it "should success" do
      post :create, :email => 'parent@test.com', :password => 'parent', :format => :json, :key => @client_application.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      json_response['parent']['id'].should_not be_blank
      json_response['parent']['authentication_token'].should_not be_blank
      Parent.last.client_applications.should be_include(@client_application)
    end

    it "should not add new association for parent and existing client_application" do
      @parent.parent_client_applications.create(:client_application => @client_application)
      @parent.should have(1).client_applications
      post :create, :email => 'parent@test.com', :password => 'parent', :format => :json, :key => @client_application.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
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
