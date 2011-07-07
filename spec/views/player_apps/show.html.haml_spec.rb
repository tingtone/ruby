require 'spec_helper'

describe "player_apps/show.html.haml" do
  before(:each) do
    @player_app = assign(:player_app, stub_model(PlayerApp))
  end

  it "renders attributes in <p>" do
    render
  end
end
