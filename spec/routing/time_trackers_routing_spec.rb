require "spec_helper"

describe TimeTrackersController do
  describe "routing" do

    it "routes to #index" do
      get("/time_trackers").should route_to("time_trackers#index")
    end

    it "routes to #new" do
      get("/time_trackers/new").should route_to("time_trackers#new")
    end

    it "routes to #show" do
      get("/time_trackers/1").should route_to("time_trackers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/time_trackers/1/edit").should route_to("time_trackers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/time_trackers").should route_to("time_trackers#create")
    end

    it "routes to #update" do
      put("/time_trackers/1").should route_to("time_trackers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/time_trackers/1").should route_to("time_trackers#destroy", :id => "1")
    end

  end
end
