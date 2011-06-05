require 'spec_helper'

describe Api::V1::PasswordsController do
  context "create" do
    before do
      @parent = Factory(:parent)
    end

    it "should success" do
      post :create, :parent_id => @parent.id, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false
    end
  end
end
