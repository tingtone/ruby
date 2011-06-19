# 
#  sessions_controller.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Forum::SessionsController < Devise::SessionsController
  layout 'forum'

  def after_sign_in_path_for(resource)
    forum_root_path
  end

  def after_sign_out_path_for(resource)
    new_forum_user_session_path
  end
end
