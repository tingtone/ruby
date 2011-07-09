require 'spec_helper'

describe Api::V1::AppsController do
  context "index" do
    it "no exchange" do
      @developer = Factory(:developer, :exchange_app => 0)
      @app = Factory(:app, :developer => @developer)
      get :index, :key => @app.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      json_response['apps'].should be_nil
    end

    it "with exchange own" do
      @developer = Factory(:developer, :exchange_app => 1)
      @app1 = Factory(:app, :developer => @developer)
      @app2 = Factory(:app, :developer => @developer)
      @app3 = Factory(:app, :developer => @developer, :icon => File.new(Rails.root.join("public/images/rails.png")))
      Factory(:app)
      get :index, :key => @app1.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      app2 = json_response['apps'].first
      app2['name'].should == @app2.name
      app2['description'].should == @app2.description
      app2['app_store_url'].should == @app2.app_store_url
      app2['icon_url'].should match(%r{http://localhost:3000/public/icons/default/missing.png})

      app3 = json_response['apps'].last
      app3['name'].should == @app3.name
      app3['description'].should == @app3.description
      app3['app_store_url'].should == @app3.app_store_url
      app3['icon_url'].should match(%r{http://localhost:3000/public/uploads/apps/icons/.*/rails_default.png})
    end

    it "with exchange all" do
      @developer = Factory(:developer, :exchange_app => 2)
      @app1 = Factory(:app, :developer => @developer)
      @app2 = Factory(:app, :icon => File.new(Rails.root.join("public/images/rails.png")))
      get :index, :key => @app1.key, :no_sign => true

      response.should be_ok
      json_response = ActiveSupport::JSON.decode response.body
      json_response['error'].should == false

      app2 = json_response['apps'].first
      app2['name'].should == @app2.name
      app2['description'].should == @app2.description
      app2['app_store_url'].should == @app2.app_store_url
      app2['icon_url'].should match(%r{http://localhost:3000/public/uploads/apps/icons/.*/rails_default.png})
    end
  end
end
