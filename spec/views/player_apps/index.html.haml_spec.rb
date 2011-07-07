require 'spec_helper'

describe "player_apps/index.html.haml" do
  before(:each) do
    assign(:player_apps, [
      stub_model(PlayerApp),
      stub_model(PlayerApp)
    ])
  end

  it "renders a list of player_apps" do
    render
  end
end
