require 'spec_helper'

describe Forum::ForumsController  do
  
  context "not loged in" do
    it "should redirect to sign in page of the parent if you not login" do
      get :index
      response.code.should == "302"
    end
  end
  
  context "loged in" do
    login_parent
    
    context " get index or show  " do
      it "should get index" do
        get :index
        response.should be_success
      end
    end
    
    context "create a forum" do
      it "should can be create a forum" do
        post :create, :forum => { :name => 'Games', :description => 'Talk about something about games' }
        response.response_code.should == 302
        @forum = assigns[:forum]
        @forum.permalink.should == "games"
        @forum.position.should == 1
        @forum.description_html.should == "<p>Talk about something about games</p>"
        @forum.state.should == "public"
      end
      
      it "should can be update a forum" do
        forum = Factory(:forum)
        put :update, :forum =>{ :name => "Apps"}, :id => forum.permalink
        @forum = assigns[:forum]
        @forum.name == "Apps"
        @forum.permalink.should == "control-room"
        @forum.position.should  == 1
      end
      
      
    end
    
    
    
    
  end
  
end

# p.name 'Control Room'
# p.description 'Talk about something of the ParentDashboard'
# p.topics_count 0
# p.posts_count 0
# p.position 1
# p.description_html '<p>Talk about something of the ParentDashboard</p>'
# p.state 'public'
# p.permalink 'control-room'