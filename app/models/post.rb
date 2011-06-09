class Post < ActiveRecord::Base
  # formats_attributes :body

  # author of post
  belongs_to :parent, :counter_cache => true
  
  belongs_to :topic, :counter_cache => true
  
  # topic's forum (set by callback)
  belongs_to :forum, :counter_cache => true
end