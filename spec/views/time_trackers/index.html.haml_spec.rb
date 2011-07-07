require 'spec_helper'

describe "time_trackers/index.html.haml" do
  before(:each) do
    assign(:time_trackers, [
      stub_model(TimeTracker),
      stub_model(TimeTracker)
    ])
  end

  it "renders a list of time_trackers" do
    render
  end
end
