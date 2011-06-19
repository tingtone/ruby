# 
#  guest_perm.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __kittyPad.com__. All rights reserved.
# 


class Permissions::GuestPerm
  
  def self.got_permissions current_ability
    # can :read, [Forum, Topic, Post]
    current_ability.can :read, [Forum, Topic, Post]
    current_ability.can :create, Post
  end
end