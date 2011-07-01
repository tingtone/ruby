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
  include Mongoid::CounterCache
  counter_cache name: :forum, inverse_of: :posts
  counter_cache name: :forum_user, inverse_of: :posts
  counter_cache name: :topic, inverse_of: :posts
  cache
  
  #fields
  field :content
  
  referenced_in :forum_user
  referenced_in :topic
  referenced_in :forum
  
end
