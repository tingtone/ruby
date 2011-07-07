require "spec_helper"

describe ScoreTrackersController do
  describe "routing" do

    it "routes to #index" do
      get("/score_trackers").should route_to("score_trackers#index")
    end

    it "routes to #new" do
      get("/score_trackers/new").should route_to("score_trackers#new")
    end

    it "routes to #show" do
      get("/score_trackers/1").should route_to("score_trackers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/score_trackers/1/edit").should route_to("score_trackers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/score_trackers").should route_to("score_trackers#create")
    end

    it "routes to #update" do
      put("/score_trackers/1").should route_to("score_trackers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/score_trackers/1").should route_to("score_trackers#destroy", :id => "1")
    end

  end
end
