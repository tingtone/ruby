require 'spec_helper'

describe Api::V1::ChildrenController do
  before do
    @parent = Factory(:parent)
  end

  context 'create' do
    it "should success" do
      child = Factory(:child, :parent => @parent)
      post :create, :child => { :fullname => 'Child', :gender => 'male', :birthday => '2000-01-01' }, :parent_id => @parent.id, :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      children = json_response['children']
      children.first['fullname'].should == child.fullname
      children.last['fullname'].should == 'Child'
    end

    it "should fail for validation" do
      post :create, :child => { :gender => 'male', :birthday => '2000-01-01' }, :parent_id => @parent.id, :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["Fullname can't be blank"]
    end

    it "should fail for wrong parent_token" do
      post :create, :child => { :gender => 'male', :birthday => '2000-01-01' }, :parent_id => -1, :format => 'json', :no_sign => true

      response.response_code.should == 200
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["no such parent"]
    end
  end

  context "index" do
    it "should get all children" do
      child1 = Factory(:child, :parent => @parent)
      child2 = Factory(:child, :parent => @parent)
      get :index, :parent_id => @parent.id, :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      children = json_response['children']
      children.first['fullname'].should == child1.fullname
      children.last['fullname'].should == child2.fullname
    end
  end
end
