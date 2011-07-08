require 'spec_helper'

describe "top_tens/show.html.haml" do
  before(:each) do
    @top_ten = assign(:top_ten, stub_model(TopTen))
  end

  it "renders attributes in <p>" do
    render
  end
end
