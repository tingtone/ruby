# 
#  role.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Role
  include Shared::Mongoid
  
  
  #fields
  field :name
  
  references_and_referenced_in_many :roles
end