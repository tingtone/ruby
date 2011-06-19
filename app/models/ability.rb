# 
#  ability.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
#  Define abilities for Cancan

class Ability

  include CanCan::Ability
  
  # Called by cancan with the current_forum_user or current_user or nil if
  # no ForumUser signed in. If so, we use guest_user
  # if guest_user, this means the session belongs to a not
  # signed in ForumUser.
  # Look: https://github.com/plataformatec/devise/wiki/How-To:-Create-a-guest-user
  
  def initialize(forum_user)
    forum_user ||= guest_user
    Permissions::ContorlCenter.dispatch(self, forum_user)
  end

  def guest_user
    ForumUser.where(name: /guest/).first # guest ForumUser
  end #guest_user

end#Ability


