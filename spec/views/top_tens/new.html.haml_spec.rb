require 'spec_helper'

describe "top_tens/new.html.haml" do
  before(:each) do
    assign(:top_ten, stub_model(TopTen).as_new_record)
  end

  it "renders new top_ten form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => top_tens_path, :method => "post" do
    end
  end
end
