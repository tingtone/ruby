# 
#  control_center.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Permissions::ContorlCenter
  
  class << self

    def dispatch(current_ability, forum_user)
      if forum_user.has_role? :admin
        Rails.logger.debug("----------------->   dispatch admin")
        AdminPerm.got_permissions current_ability
      elsif forum_user.has_role? :parent
        Rails.logger.debug("----------------->   dispatch parent")
        ParentPerm.got_permissions current_ability
      elsif forum_user.has_role? :developer
        Rails.logger.debug("----------------->   dispatch developer")
        DeveloperPerm.got_permissions current_ability
      elsif forum_user.has_role? :guest
        Rails.logger.debug("----------------->   dispatch guest")
        GuestPerm.got_permissions current_ability
      else
        Rails.logger.debug("----------------->   dispatch Any Body")
        current_ability.can :read, [Forum,Topic, Post]
        current_ability.can :about, Forum
        
      end
    end

  end

end
