require "spec_helper"

describe PlayerAppsController do
  describe "routing" do

    it "routes to #index" do
      get("/player_apps").should route_to("player_apps#index")
    end

    it "routes to #new" do
      get("/player_apps/new").should route_to("player_apps#new")
    end

    it "routes to #show" do
      get("/player_apps/1").should route_to("player_apps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/player_apps/1/edit").should route_to("player_apps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/player_apps").should route_to("player_apps#create")
    end

    it "routes to #update" do
      put("/player_apps/1").should route_to("player_apps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/player_apps/1").should route_to("player_apps#destroy", :id => "1")
    end

  end
end
