require 'spec_helper'

describe Forum do

  before do
    @parent = Factory(:parent)
    @forum = Factory(:forum)
  end


  it "Reply Topic Default" do
    params = {}
    params["title"] = "yes you got it!"
    params["body"] = "yes you got it!"

    topic = @parent.post(@forum,params)
    topic.should_not == nil
    topic.title.should == params["title"]
    topic.sticky.should == 0
    topic.locked.should == false
    puts topic.errors.inspect
    topic.new_record?.should == false

    post = @parent.reply topic, "yes,reply :)"
    post.forum.should == topic.forum
    post.parent.should == @parent

    post.destroy
  end



end