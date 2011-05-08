require 'spec_helper'

describe Api::V1::ChildClientApplicationsController do
  context "create" do
    before do
      @child = Factory(:child)
      @client_application = Factory(:client_application)
    end

    it "should success" do
      post :create, :time => 60, :child_id => @child.id, :key => @client_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      child_client_application = ChildClientApplication.last
      child_client_application.time.should == 60
      child_client_application.child.should == @child
      child_client_application.client_application.should == @client_application
    end

    it "should fail" do
      post :create, :child_id => @child.id, :key => @client_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
    end
  end
end
