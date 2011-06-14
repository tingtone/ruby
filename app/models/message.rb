class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  
  cache
  
  #fields
  field :title
  field :content
  
  embedded_in :forum_user
  
  field :send_id
  field :group_message_id
  
  field :status, :type => String, :default => "new"
  
end