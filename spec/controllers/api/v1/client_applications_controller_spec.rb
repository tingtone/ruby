require 'spec_helper'

describe Api::V1::ClientApplicationsController do
  before do
    @parent = Factory(:parent, :authentication_token => '1234')
  end

  context "index" do
    it "should get all client applications" do
      client_application1 = Factory(:client_application)
      client_application2 = Factory(:client_application)
      Factory(:parent_client_application, :parent => @parent, :client_application => client_application1)
      Factory(:parent_client_application, :parent => @parent, :client_application => client_application2)
      get :index, :parent_token => '1234', :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      client_applications = json_response['client_applications']
      client_applications.first['name'].should == client_application1.name
      client_applications.last['name'].should == client_application2.name
    end
  end
end
