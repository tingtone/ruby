require 'spec_helper'

describe "score_trackers/edit.html.haml" do
  before(:each) do
    @score_tracker = assign(:score_tracker, stub_model(ScoreTracker))
  end

  it "renders the edit score_tracker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => score_trackers_path(@score_tracker), :method => "post" do
    end
  end
end
