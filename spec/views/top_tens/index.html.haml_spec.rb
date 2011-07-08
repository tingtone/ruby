require 'spec_helper'

describe "top_tens/index.html.haml" do
  before(:each) do
    assign(:top_tens, [
      stub_model(TopTen),
      stub_model(TopTen)
    ])
  end

  it "renders a list of top_tens" do
    render
  end
end
