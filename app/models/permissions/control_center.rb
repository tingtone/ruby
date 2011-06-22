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
        Permissions::AdminPerm.got_permissions current_ability
      elsif forum_user.has_role? :parent
        Permissions::ParentPerm.got_permissions current_ability
      elsif forum_user.has_role? :developer
        Permissions::DeveloperPerm.got_permissions current_ability
      elsif forum_user.has_role? :guest
        Permissions::GuestPerm.got_permissions current_ability
      else
        current_ability.can :read, [Forum,Topic, Post]
        current_ability.can :about, Forum
        current_ability.can :news,  Forum
      end
    end

  end

end
