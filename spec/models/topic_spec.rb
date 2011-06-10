require 'spec_helper'

describe Forum do

  before do
    @parent = Factory(:parent)
    @forum = Factory(:forum)
  end


  it "Create New Topic Default" do
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
  end

  it "Create New Topic Admin" do
    params = {}
    params[:title] = "yes you got it!"
    params[:body] = "yes you got it!"
    params[:sticky] = 1
    Moderatorship.create(:parent_id => @parent.id, :forum_id => @forum.id)
    Moderatorship.exists?(:parent_id => @parent.id, :forum_id => @forum.id).should == true

    topic = @parent.post(@forum,params)
    topic.should_not == nil
    topic.title.should == params[:title]
    topic.sticky.should == params[:sticky]
    puts topic.errors.inspect
    topic.new_record?.should == false
  end

  it "Create New Topic With Locked" do
    params = {}
    params[:title] = "yes you got it!"
    params[:body] = "yes you got it!"
    params[:sticky] = 1
    params[:locked] = 1
    Moderatorship.create(:parent_id => @parent.id, :forum_id => @forum.id)
    Moderatorship.exists?(:parent_id => @parent.id, :forum_id => @forum.id).should == true

    topic = @parent.post(@forum,params)
    topic.should_not == nil
    topic.title.should == params[:title]
    topic.sticky.should == params[:sticky]
    topic.locked.should == true
    puts topic.errors.inspect
    topic.new_record?.should == false
  end

  it "Create New Topic for revise" do
    params = {}
    params[:title] = "yes you got it!"
    params[:body] = "yes you got it!"
    params[:sticky] = 1
    params[:locked] = 1
    Moderatorship.create(:parent_id => @parent.id, :forum_id => @forum.id)
    Moderatorship.exists?(:parent_id => @parent.id, :forum_id => @forum.id).should == true

    topic = @parent.post(@forum,params)
    topic.should_not == nil
    topic.title.should == params[:title]
    topic.sticky.should == params[:sticky]
    topic.locked.should == true
    puts topic.errors.inspect
    topic.new_record?.should == false

    params[:title] = "revise you got it!"
    @parent.revise(topic, params)
    topic.errors.empty?.should == true
    topic.title.should == params[:title]

  end

  it "Delete Topic" do
    params = {}
    params[:title] = "yes you got it!"
    params[:body] = "yes you got it!"

    topic = @parent.post(@forum,params)
    topic.should_not == nil
    topic.title.should == params[:title]
    puts topic.errors.inspect
    topic.new_record?.should == false
    topic.destroy

  end



  it "#hit! increments hits counter" do
    params = {}
    params["title"] = "yes you got it!"
    params["body"] = "yes you got it!"
    topic = @parent.post(@forum,params)
    lambda { topic.hit! }.should change { topic.reload.hits }.by(1)
  end





end