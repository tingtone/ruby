# 
#  guest_perm.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __kittyPad.com__. All rights reserved.
# 


class GuestPerm
  def self.got_permissions
    # can :read, [Forum, Topic, Post]
    can :read, [Forum]
    can :create, Post
  end
end