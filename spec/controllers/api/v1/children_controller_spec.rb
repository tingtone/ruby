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
      json_response['messages'].should == ["no such parent authentication token"]
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
      children.first['email'].should == child1.email
      children.last['email'].should == child2.email
    end
  end

  context "show" do
    it "should get child" do
      child = Factory(:child, :email => 'child@test.com', :parent => @parent)
      grade1 = Factory(:grade, :name => 'junior')
      grade2 = Factory(:grade, :name => 'senior')
      client_application1 = Factory(:client_application, :name => 'app1')
      client_application2 = Factory(:client_application, :name => 'app2')
      Factory(:achievement, :child => child, :grade => grade1, :course => 'chinese', :score => 10000)
      Factory(:achievement, :child => child, :grade => grade2, :course => 'maths', :score => 20000)
      Factory(:child_client_application, :child => child, :client_application => client_application1, :time => 1000)
      Factory(:child_client_application, :child => child, :client_application => client_application2, :time => 2000)
      get :show, :id => child.id, :parent_token => '1234', :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      child = json_response['child']
      child['email'].should == 'child@test.com'
      achievements = child['achievements']
      achievements.first['score'].should == 10000
      achievements.first['grade_name'].should == 'junior'
      achievements.first['course'].should == 'chinese'
      achievements.last['score'].should == 20000
      achievements.last['grade_name'].should == 'senior'
      achievements.last['course'].should == 'maths'
      applists = child['applists']
      applists.first['client_application']['name'] = 'app1'
      applists.first['time'] = 1000
      applists.last['client_application']['name'] = 'app2'
      applists.last['time'] = 2000
    end
  end
end
