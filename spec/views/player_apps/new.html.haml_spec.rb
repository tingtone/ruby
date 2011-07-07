require 'spec_helper'

describe "player_apps/new.html.haml" do
  before(:each) do
    assign(:player_app, stub_model(PlayerApp).as_new_record)
  end

  it "renders new player_app form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => player_apps_path, :method => "post" do
    end
  end
end
