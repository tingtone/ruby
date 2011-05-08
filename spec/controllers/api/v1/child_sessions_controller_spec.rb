require 'spec_helper'

describe Api::V1::ChildSessionsController do
  context "sign in" do
    before do
      @parent = Factory(:parent)
      Factory(:child, :fullname => 'Child', :gender => 'male', :birthday => '2000-01-01', :parent => @parent)
    end

    it "should success" do
      post :create, :fullname => 'Child', :parent_id => @parent.id, :format => :json, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      json_response['child']['id'].should_not be_blank
    end

    it "should fail" do
      post :create, :fullname => 'Nobody', :parent_id => @parent.id, :format => :json, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
    end
  end
end
