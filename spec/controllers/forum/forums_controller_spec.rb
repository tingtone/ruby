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
        response.should be_ok
        @forum = Forum.find_by_name('Games')
        @forum.permalink.should == "games"
        @forum.position.should == 1
        @forum.description_html.should == "<p>Talk about something about games</p>"
        @forum.state == 'public'
        
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