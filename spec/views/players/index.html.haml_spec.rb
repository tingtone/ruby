require 'spec_helper'

describe "players/index.html.haml" do
  before(:each) do
    assign(:players, [
      stub_model(Player),
      stub_model(Player)
    ])
  end

  it "renders a list of players" do
    render
  end
end
