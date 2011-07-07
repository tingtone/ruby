require 'spec_helper'

describe "time_trackers/new.html.haml" do
  before(:each) do
    assign(:time_tracker, stub_model(TimeTracker).as_new_record)
  end

  it "renders new time_tracker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => time_trackers_path, :method => "post" do
    end
  end
end
