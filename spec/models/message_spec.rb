require 'spec_helper'


describe "Message" do
  before do
    ForumUser.delete_all
    Message.delete_all
    GroupMessage.delete_all
    @sender = ForumUser.new({:name=>"edison",:email=>"1@121d63.com",:password=>"dafdddfawwq2"})
    @sender.save
    @reciever = ForumUser.new({:name=>"Alex",:email=>"2@12163.com",:password=>"dafdfawwq2"})
    @reciever.save
  end

  it "create message" do
    m = @sender.send_message(@reciever,"hi alex","yes!!:)")
    m.should_not == nil
    m.recipient.should == @reciever
    m.sender.should == @sender
    @sender.messages.should_not == []
  end

  it "delete message" do
    m = @sender.send_message(@reciever,"hi alex","yes!!:)")
    m.should_not == nil
    m.recipient.should == @reciever
    m.sender.should == @sender
    @sender.messages.should_not == []
    m.delete(@sender)
    m.recipient_deleted.should == false
    m.sender_deleted.should == true
    m.delete(@reciever)
    m.recipient_deleted.should == true
    m.sender_deleted.should == true
  end

  it "inbox" do
    m = @sender.send_message(@reciever,"hi alex","yes!!:)")
    m.should_not == nil
    m.recipient.should == @reciever
    m.sender.should == @sender
    @sender.messages.should_not == []
    params = {}
    params["page"] = 1
    ms = Message.inbox(@reciever,params)
    ms.length.should_not == 0
  end

  it "outbox" do
    m = @sender.send_message(@reciever,"hi alex","yes!!:)")
    m.should_not == nil
    m.recipient.should == @reciever
    m.sender.should == @sender
    @sender.messages.should_not == []
    params = {}
    params["page"] = 1
    ms = Message.outbox(@sender,params)
    ms.length.should_not == 0
  end

  it "drops multi message" do
     m = @sender.send_message(@reciever,"hi alex","yes!!:)")
     m.should_not == nil
     m.recipient.should == @reciever
     m.sender.should == @sender
     Message.drops(@sender,[m.id],"inbox").should_not == nil
     Message.drops(@reciever,[m.id],"outbox").should_not == nil
  end

  it "group message" do
    gms = @sender.send_group_message("grouping","notice")
    gms.sender.should == @sender
    @sender.check_group_messages.should == true

  end

  it "black list" do
    success = @sender.add_black_list(@reciever)
    success.should == true
    #@sender.black_list.blacks.length.should == 1
    @sender.black?(@reciever).should == true
    FblackList.list(@sender,{}).should_not == []
  end

end