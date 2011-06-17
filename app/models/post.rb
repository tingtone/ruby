# 
#  post.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 
 

class Post
  include Shared::Mongoid
  include Shared::Mongoid::ActTree

  cache
  
  #fields
  field :content
  
  referenced_in :forum_user
  referenced_in :topic
  referenced_in :forum
  

  
end
