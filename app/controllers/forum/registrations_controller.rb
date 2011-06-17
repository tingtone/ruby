# 
#  registrations_controller.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Forum::RegistrationsController < Devise::RegistrationsController
  layout 'forum'

  def after_sign_up_path_for(resource)
     forum_root_path
   end

   def after_update_path_for(resource)
     forum_root_path
   end

   def after_sign_up_path_for(resource)
     new_forum_user_session_path
   end
end
