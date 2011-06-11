require 'spec_helper'

describe Api::V1::ClientApplicationsController do
  context "kind" do
    it "should be GameApplication" do
      @game_application = Factory(:game_application)

      get :kind, :key => @game_application.key, :no_sign => true
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should be_false
      json_response['kind'].should == 'GameApplication'
    end

    it "should be EducationApplication" do
      @education_application = Factory(:education_application)

      get :kind, :key => @education_application.key, :no_sign => true
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should be_false
      json_response['kind'].should == 'EducationApplication'
    end
  end
end
