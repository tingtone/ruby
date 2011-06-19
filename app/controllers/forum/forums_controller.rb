# 
#  forums_controller.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 

class Forum::ForumsController < Forum::BaseController
  # before_filter :authenticate_forum_user!, :only => [:new, :edit, :create, :update]
  inherit_resources
  load_and_authorize_resource
  
  
  
  def index
    @forums = Forum.ordered_forums
  end
  
  def create
    create!{ forum_forums_path }
  end
  
  def update
    update!{ forum_forums_path }
  end
  
  # def about
  #     
  #   end #about
  
end