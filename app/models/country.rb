# 
#  country.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Country
  include Shared::Mongoid
  
  cache
  
  #fields
  field :name
  
  references_many :states
end