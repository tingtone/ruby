require 'spec_helper'

describe "time_trackers/show.html.haml" do
  before(:each) do
    @time_tracker = assign(:time_tracker, stub_model(TimeTracker))
  end

  it "renders attributes in <p>" do
    render
  end
end
