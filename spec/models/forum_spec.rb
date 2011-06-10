require 'spec_helper'

describe Forum do
  before do
    @forum = Factory(:forum)
    @forum_two = Factory(:forum_two)
    @parent = Factory(:parent)
  end
  
  it "finds ordered forums" do
    Forum.ordered_forums.should == [@forum, @forum_two]
  end
  
  it "can be set  Moderator for a formu user" do
    @moderatorship = @forum.set_moderator(@parent)
    @moderatorship.forum_id == 1
    @moderatorship.parent_id == 1
  end
  
end