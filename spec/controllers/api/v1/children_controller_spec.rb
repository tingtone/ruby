require 'spec_helper'

describe Api::V1::ChildrenController do
  before do
    @parent = Factory(:parent)
  end

  context 'create' do
    it "should success" do
      child = Factory(:child, :parent => @parent)
      post :create, :child => { :fullname => 'Child', :gender => 'male', :birthday => '1262275200' }, :parent_id => @parent.id, :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
      json_response['child']['id'].should_not be_blank
    end

    it "should success with rule_definitions" do
      client_application = Factory(:client_application)
      post :create, :child => { :fullname => 'Child', :gender => 'male', :birthday => '1262275200', :rule_definitions_attributes => {"0" => {:period => 'day', :time => 60}, "1" => {:period => 'week', :time => 120}, "2" => {:period => 'day', :time => 30, :client_application_id => client_application.id}, "3" => {:period => 'week', :time => 60, :client_application_id => client_application.id}} }, :parent_id => @parent.id, :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      RuleDefinition.find_all_by_child_id(Child.last.id).size.should == 4
      RuleDefinition.find_all_by_client_application_id(client_application.id).size.should == 2
    end

    it "should upload avatar for child" do
      client_application = Factory(:client_application)
      post :create, :child => { :fullname => 'Child', :gender => 'male', :birthday => '1262275200', :avatar => File.new(Rails.root.join('public/images/rails.png')) }, :parent_id => @parent.id, :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
    end

    it "should fail for validation" do
      post :create, :child => { :gender => 'male', :birthday => '1262275200' }, :parent_id => @parent.id, :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["Fullname can't be blank"]
    end

    it "should fail for wrong parent_token" do
      post :create, :child => { :gender => 'male', :birthday => '1262275200' }, :parent_id => -1, :format => 'json', :no_sign => true

      response.response_code.should == 200
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == true
      json_response['messages'].should == ["no such parent"]
    end
  end

  context 'update' do
    it "should success" do
      child = Factory(:child, :parent => @parent)
      put :update, :child => { :fullname => 'Update' }, :id => child.id, :parent_id => @parent.id, :format => 'json', :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
    end

    it "should update rule definition" do
      child = Factory(:child, :parent => @parent)
      client_application = Factory(:client_application)

      put :update, :id => child.id, :child => { :rule_definitions_attributes => {"0" => {:period => 'day', :time => 60}, "1" => {:period => 'week', :time => 120}, "2" => {:period => 'day', :time => 30, :client_application_id => client_application.id}, "3" => {:period => 'week', :time => 60, :client_application_id => client_application.id}} }, :parent_id => @parent.id, :format => 'json', :no_sign => true
      child.rule_definitions.find_by_client_application_id_and_period(client_application.id, 'day').time.should == 30
      child.rule_definitions.find_by_client_application_id_and_period(client_application.id, 'week').time.should == 60
      child.rule_definitions.find_by_client_application_id_and_period(nil, 'day').time.should == 60
      child.rule_definitions.find_by_client_application_id_and_period(nil, 'week').time.should == 120
    end
  end
end
