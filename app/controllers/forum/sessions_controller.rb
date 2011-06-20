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
    if current_forum_user.from_pad? || !current_forum_user.from_dev?
      parent_user = Parent.find_by_name(current_forum_user.name) 
      sign_in(:parent, parent_user)
    elsif current_forum_user.from_dev?
      dev_user = Developer.find_by_name(current_forum_user.name) 
      sign_in(:developer, dev_user)
    end
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
