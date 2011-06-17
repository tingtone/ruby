# 
#  any_body.rb
#  ruby
#  
#  Created by Zhang alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class AnyBody
  def self.got_permissions
    can :read, [Forum, Topic, Post]
  end
end