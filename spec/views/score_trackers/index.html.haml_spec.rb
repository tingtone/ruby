require 'spec_helper'

describe "score_trackers/index.html.haml" do
  before(:each) do
    assign(:score_trackers, [
      stub_model(ScoreTracker),
      stub_model(ScoreTracker)
    ])
  end

  it "renders a list of score_trackers" do
    render
  end
end
