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
  # no ForumUser signed in. If so, we create a new ForumUser object which can be
  # identified as an anonymous ForumUser by calling new_record? on it.
  # if ForumUser.new_record? is true this means the session belongs to a not
  # signed in ForumUser.
  def initialize(forum_user)
    forum_user ||= @guest_user # guest ForumUser
 
    Permissions::ContorlCenter.dispatch forum_user
  end


end#Ability


