require 'spec_helper'

describe "time_trackers/edit.html.haml" do
  before(:each) do
    @time_tracker = assign(:time_tracker, stub_model(TimeTracker))
  end

  it "renders the edit time_tracker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => time_trackers_path(@time_tracker), :method => "post" do
    end
  end
end
