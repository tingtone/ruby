require 'spec_helper'

describe "top_tens/edit.html.haml" do
  before(:each) do
    @top_ten = assign(:top_ten, stub_model(TopTen))
  end

  it "renders the edit top_ten form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => top_tens_path(@top_ten), :method => "post" do
    end
  end
end
