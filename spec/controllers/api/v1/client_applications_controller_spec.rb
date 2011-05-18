require 'spec_helper'

describe Api::V1::ClientApplicationsController do
  context "sync" do
    before do
      @parent = Factory(:parent)
      @parent.update_attribute(:total_time, 1000)
      @child1 = Factory(:child, :parent => @parent)
      @child2 = Factory(:child, :parent => @parent)
      @game_application1 = Factory(:game_application)
      @game_application2 = Factory(:game_application)
      Factory(:time_tracker, :child => @child1, :client_application => @game_application1, :time => 50)
      Factory(:time_tracker, :child => @child1, :client_application => @game_application2, :time => 100)
      Factory(:time_tracker, :child => @child2, :client_application => @game_application1, :time => 150)
      Factory(:time_tracker, :child => @child2, :client_application => @game_application2, :time => 200)

      Factory(:rule_definition, :parent => @parent, :client_application => @game_application1, :time => 600, :period => 'day')
    end

    it "should get json summary" do
      get :sync, :child_id => @child1.id, :parent_id => @parent.id, :key => @game_application1.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should be_false
      json_response['game_left_time'].should == 550
      json_response['total_left_time'].should == 850
    end
  end
end
