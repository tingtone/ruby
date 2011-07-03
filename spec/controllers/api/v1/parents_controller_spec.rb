require 'spec_helper'

describe Api::V1::ParentsController do
  context "create a parent" do
    before do
      @client_application = Factory(:education_application)
    end

    it "should success to create a parent" do
      post :save, :parent => {:email => 'parent@test.com', :password => 'parent', :password_confirmation => 'parent'}, :device => {:identifier => 'device-identifier'}, :format => :json, :key => @client_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      Parent.last.client_applications.should be_include(@client_application)
      Parent.last.devices.should be_include(Device.last)
      Parent.last.name.should_not == 'parentsss'
      Parent.last.name.should == 'parent'
      
      Device.last.identifier.should == 'device-identifier'
    end

    it "should success to update a parent" do
      parent = Factory(:parent, :email => 'parent@test.com')
      device = Factory(:device, :parent => parent)

      post :save, :parent => {:email => 'parent@test.com', :password => 'parent', :password_confirmation => 'parent'}, :device => {:identifier => 'device-identifier'}, :format => :json, :key => @client_application.key, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      parent.reload
      device.reload
      parent.client_applications.collect(&:id).should be_include(@client_application.id)
      parent.devices.collect(&:id).should be_include(device.id)
    end

    it "should fail" do
      post :save, :parent => {:email => 'parent@test.com'}, :format => :json, :no_sign => true
      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["Password can't be blank"]
    end
  end
end
