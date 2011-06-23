# 
#  guest_perm.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __kittyPad.com__. All rights reserved.
# 


class Permissions::GuestPerm
  
  def self.got_permissions current_ability
    current_ability.can :read, [Forum, Topic, Post, Search]
    current_ability.can :about, Forum
    current_ability.can :news,  Forum
    current_ability.can :sign_up,  Forum
    current_ability.can [:index, :create], Search
  end
end