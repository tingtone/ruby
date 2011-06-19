require 'spec_helper'

describe Api::V1::ParentSessionsController do
  context "sign in" do
    before do
      @client_application = Factory(:game_application)
      @parent = Factory(:parent, :email => 'parent@test.com', :password => 'parent', :password_confirmation => 'parent')
      @child1 = Factory(:child, :parent => @parent, :created_at => Time.now.ago(3.days), :updated_at => Time.now.ago(2.days))
      @child2 = Factory(:child, :parent => @parent, :created_at => Time.now.ago(2.days), :updated_at => Time.now.ago(1.day))
      @parent.update_attribute(:children_updated_at, Time.now.ago(1.day))
      Factory(:time_tracker, :child => @child1, :client_application => @client_application, :time => 5)
      Factory(:time_tracker, :child => @child2, :client_application => @client_application, :time => 10)
      @bonus1 = Factory(:bonus, :child => @child1, :expired_on => Date.today.since(10.weeks), :created_at => Time.now.ago(3.days), :updated_at => Time.now.ago(3.days))
      @bonus2 = Factory(:bonus, :child => @child1, :expired_on => Date.today.since(11.weeks), :created_at => Time.now.ago(2.days), :updated_at => Time.now.ago(2.days))
      @bonus3 = Factory(:bonus, :child => @child2, :expired_on => Date.today.since(12.weeks), :created_at => Time.now.ago(1.day), :updated_at => Time.now.ago(1.day))
      @parent.update_attribute(:bonus_updated_at, Time.now.ago(1.day))
    end

    context "without timestamp" do
      it "should success" do
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false
        json_response['parent']['id'].should_not be_blank
        json_response['parent']['email'].should be_blank
        json_response['parent']['client_encrypted_password'].should be_blank
        json_response['parent']['authentication_token'].should_not be_blank
        Parent.last.client_applications.should be_include(@client_application)

        children = json_response['parent']['children']
        children.first['id'].should == @child1.id
        children.last['id'].should == @child2.id

        time_summary = json_response['time_summary']
        time_summary.first['game_day_left_time'].should == 55
        time_summary.first['total_day_left_time'].should == 145
        time_summary.first['game_week_left_time'].should == 85
        time_summary.first['total_week_left_time'].should == 265
        time_summary.first['child_id'].should == @child1.id

        time_summary.last['game_day_left_time'].should == 35
        time_summary.last['total_day_left_time'].should == 125
        time_summary.last['game_week_left_time'].should == 65
        time_summary.last['total_week_left_time'].should == 245
        time_summary.last['child_id'].should == @child2.id

        rule_definitions = json_response['parent']['rule_definitions']
        rule_definitions.first['game_day_time'].should == 30
        rule_definitions.first['game_week_time'].should == 60
        rule_definitions.first['total_day_time'].should == 120
        rule_definitions.first['total_week_time'].should == 240
        rule_definitions.first['child_id'].should == @child1.id

        rule_definitions.last['game_day_time'].should == 30
        rule_definitions.last['game_week_time'].should == 60
        rule_definitions.last['total_day_time'].should == 120
        rule_definitions.last['total_week_time'].should == 240
        rule_definitions.last['child_id'].should == @child2.id

        bonus = json_response['bonus']
        bonus.first['time'].should == 15
        bonus.first['expired_on'].should == @bonus1.expired_on.to_date.to_time.to_i
        bonus.first['child_id'].should == @child1.id

        bonus.last['time'].should == 15
        bonus.last['expired_on'].should == @bonus3.expired_on.to_date.to_time.to_i
        bonus.last['child_id'].should == @child2.id
      end

      it "should get rule definitions for child and client application" do
        Factory(:rule_definition, :child => @child1, :client_application => @client_application, :time => 40, :period => 'day')
        Factory(:rule_definition, :child => @child1, :client_application => @client_application, :time => 80, :period => 'week')
        Factory(:rule_definition, :child => @child1, :time => 140, :period => 'day')
        Factory(:rule_definition, :child => @child1, :time => 280, :period => 'week')
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false

        rule_definitions = json_response['parent']['rule_definitions']
        rule_definitions.first['game_day_time'].should == 40
        rule_definitions.first['game_week_time'].should == 80
        rule_definitions.first['total_day_time'].should == 140
        rule_definitions.first['total_week_time'].should == 280
        rule_definitions.first['child_id'].should == @child1.id

        rule_definitions.last['game_day_time'].should == 30
        rule_definitions.last['game_week_time'].should == 60
        rule_definitions.last['total_day_time'].should == 120
        rule_definitions.last['total_week_time'].should == 240
        rule_definitions.last['child_id'].should == @child2.id
      end

      it "should add a new device" do
        Device.count.should == 0
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false
        Device.count.should == 1
        Device.last.identifier.should == 'device-identifier'
      end

      it "should get global rule definitions" do
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        rule_definitions = json_response['parent']['global_rule_definitions']
        rule_definitions['game_day_time'].should == 30
        rule_definitions['game_week_time'].should == 60
        rule_definitions['total_day_time'].should == 120
        rule_definitions['total_week_time'].should == 240
      end

      it "should login without email password" do
        Factory(:device, :identifier => 'device-identifier', :parent => @parent)
        post :create, :device_identifier => 'device-identifier', :format => :json, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false
        json_response['parent']['email'].should_not be_blank
        json_response['parent']['client_encrypted_password'].should_not be_blank
      end

      it "should not add new association for parent and existing client_application" do
        @parent.parent_client_applications.create(:client_application => @client_application)
        @parent.should have(1).client_applications
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should be_false
        json_response['parent']['id'].should_not be_blank
        @parent.reload.should have(1).client_applications
      end

      it "should fail" do
        post :create, :email => 'parent@test.com', :password => 'wrong', :format => :json, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == true
      end

      it "should check email and password even if there is a device identifier" do
        post :create, :email => 'parent@test.com', :password => 'wrong', :device_identifier => 'device-identifier', :format => :json, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == true
      end
    end

    context "with timestamp" do
      it "should without children" do
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :timestamp => Time.now.utc.ago(12.hours).to_i, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false
        json_response['parent']['children'].should be_nil
      end

      it "should with children" do
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :timestamp => Time.now.utc.ago(2.days).to_i, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false

        children = json_response['parent']['children']
        children.first['id'].should == @child1.id
        children.last['id'].should == @child2.id
      end

      it "should without rule_definitions" do
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :timestamp => Time.now.utc.ago(12.hours).to_i, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false
        json_response['parent']['rule_definitions'].should be_nil
      end

      it "should with rule_definitions" do
        Factory(:rule_definition, :child => @child1, :client_application => @client_application, :time => 40, :period => 'day', :created_at => Time.now.ago(1.days), :updated_at => Time.now.ago(1.days))
        Factory(:rule_definition, :child => @child1, :client_application => @client_application, :time => 80, :period => 'week', :created_at => Time.now.ago(1.days), :updated_at => Time.now.ago(1.days))
        Factory(:rule_definition, :child => @child1, :time => 140, :period => 'day', :created_at => Time.now.ago(1.days), :updated_at => Time.now.ago(1.days))
        Factory(:rule_definition, :child => @child1, :time => 280, :period => 'week', :created_at => Time.now.ago(1.days), :updated_at => Time.now.ago(1.days))
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :timestamp => Time.now.utc.ago(2.days).to_i, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false

        rule_definitions = json_response['parent']['rule_definitions']
        rule_definitions.first['game_day_time'].should == 40
        rule_definitions.first['game_week_time'].should == 80
        rule_definitions.first['total_day_time'].should == 140
        rule_definitions.first['total_week_time'].should == 280
        rule_definitions.first['child_id'].should == @child1.id

        rule_definitions.last['game_day_time'].should == 30
        rule_definitions.last['game_week_time'].should == 60
        rule_definitions.last['total_day_time'].should == 120
        rule_definitions.last['total_week_time'].should == 240
        rule_definitions.last['child_id'].should == @child2.id
      end

      it "should without bonus" do
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :timestamp => Time.now.utc.ago(12.hours).to_i, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false
        json_response['bonus'].should be_nil
      end

      it "should with bonus" do
        post :create, :email => 'parent@test.com', :password => 'parent', :device_identifier => 'device-identifier', :format => :json, :timestamp => Time.now.utc.ago(2.days).to_i, :key => @client_application.key, :no_sign => true

        response.should be_ok
        json_response = ActiveSupport::JSON.decode response.body
        json_response['error'].should == false

        bonus = json_response['bonus']
        bonus.first['time'].should == 15
        bonus.first['expired_on'].should == @bonus1.expired_on.to_date.to_time.to_i
        bonus.first['child_id'].should == @child1.id

        bonus.last['time'].should == 15
        bonus.last['expired_on'].should == @bonus3.expired_on.to_date.to_time.to_i
        bonus.last['child_id'].should == @child2.id
      end
    end
  end
end
