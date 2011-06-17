# 
#  admin_perm.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class AdminPerm
  def self.got_permissions
    can :manage, :all  # Admin is god
  end
end