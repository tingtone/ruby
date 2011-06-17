# 
#  control_center.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class ContorlCenter
  
  class << self

    def dispatch forum_user
      if forum_user.has_role? :admin
        AdminPerm.got_permissions
      elsif forum_user.has_role? :parent
        ParentPerm.got_permissions
      elsif forum_user.has_role? :developer
        DeveloperPerm.got_permissions
      elsif forum_user.has_role? :guest
        GuestPerm.got_permissions
      else
        AnyBody.got_permissions
      end
    end

  end

end
