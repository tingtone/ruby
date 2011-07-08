require "spec_helper"

describe TopTensController do
  describe "routing" do

    it "routes to #index" do
      get("/top_tens").should route_to("top_tens#index")
    end

    it "routes to #new" do
      get("/top_tens/new").should route_to("top_tens#new")
    end

    it "routes to #show" do
      get("/top_tens/1").should route_to("top_tens#show", :id => "1")
    end

    it "routes to #edit" do
      get("/top_tens/1/edit").should route_to("top_tens#edit", :id => "1")
    end

    it "routes to #create" do
      post("/top_tens").should route_to("top_tens#create")
    end

    it "routes to #update" do
      put("/top_tens/1").should route_to("top_tens#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/top_tens/1").should route_to("top_tens#destroy", :id => "1")
    end

  end
end
