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