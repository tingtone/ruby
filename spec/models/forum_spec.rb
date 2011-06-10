require 'spec_helper'

describe Forum do
  before do
    @forum = Factory(:forum)
  end
  
  context 'show' do
    it "should show a forum" do
      puts " --- #{@forum.inspect}"
    end
  end
end