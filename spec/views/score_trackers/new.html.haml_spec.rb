require 'spec_helper'

describe "score_trackers/new.html.haml" do
  before(:each) do
    assign(:score_tracker, stub_model(ScoreTracker).as_new_record)
  end

  it "renders new score_tracker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => score_trackers_path, :method => "post" do
    end
  end
end
