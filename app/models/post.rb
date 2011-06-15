class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Mongoid::Acts::Tree
  
  cache
  
  #fields
  field :content
  
  referenced_in :forum_user
  referenced_in :topic
  referenced_in :forum
  
  acts_as_tree
  
end