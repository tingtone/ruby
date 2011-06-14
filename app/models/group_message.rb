class GroupMessage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  
  cache
  
  #fields
  field :title
  field :content
  
  referenced_in :forum_user
end