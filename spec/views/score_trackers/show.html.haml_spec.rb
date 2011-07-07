require 'spec_helper'

describe "score_trackers/show.html.haml" do
  before(:each) do
    @score_tracker = assign(:score_tracker, stub_model(ScoreTracker))
  end

  it "renders attributes in <p>" do
    render
  end
end
