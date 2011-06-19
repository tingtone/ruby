# 
#  search.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Search
  include Mongoid::Document
  include Mongoid::Timestamps

  cache

  #fields
  field :keywords
  field :typee
  
  SEARCH_TYPE = %w|Topic User App|
end