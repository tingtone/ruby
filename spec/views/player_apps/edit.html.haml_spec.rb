require 'spec_helper'

describe "player_apps/edit.html.haml" do
  before(:each) do
    @player_app = assign(:player_app, stub_model(PlayerApp))
  end

  it "renders the edit player_app form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => player_apps_path(@player_app), :method => "post" do
    end
  end
end
