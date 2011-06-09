require 'spec_helper'


describe ClientApplication do

  before do
    @app1 = Factory(:client_application)
    @app2 = Factory(:client_application)
  end

  #use rake db:seed to create development data
  it "get recommends" do
    #for recommend
    @recommends = ClientApplication.recommends(nil)
    @recommends.should_not == []
    @recommends.should_not == nil
    @recommends = ClientApplication.filters({"page"=>13})
    @recommends.should_not == []
  end

  it "get app lists" do
    #for filter apps
    @apps = ClientApplication.filters({})
    @apps.should_not == []
    @apps.should_not == nil
    @apps = ClientApplication.filters({"rating"=>9})
    @apps.should_not == []
    @apps = ClientApplication.filters({"rating"=>13})
    @apps.should == []
  end
end

