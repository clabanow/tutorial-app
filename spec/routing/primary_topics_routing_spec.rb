require "spec_helper"

describe PrimaryTopicsController do
  describe "routing" do

    it "routes to #index" do
      get("/primary_topics").should route_to("primary_topics#index")
    end

    it "routes to #new" do
      get("/primary_topics/new").should route_to("primary_topics#new")
    end

    it "routes to #show" do
      get("/primary_topics/1").should route_to("primary_topics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/primary_topics/1/edit").should route_to("primary_topics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/primary_topics").should route_to("primary_topics#create")
    end

    it "routes to #update" do
      put("/primary_topics/1").should route_to("primary_topics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/primary_topics/1").should route_to("primary_topics#destroy", :id => "1")
    end

  end
end
