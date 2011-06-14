class Topic
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  cache

  #fields
  field :title
  field :content
  
  field :hits,         :type => Integer, :default => 0
  field :sticky,       :type => Integer, :default => 0
  field :locked,       :type => Boolean, :default => false
  field :posts_count,  :type => Integer, :default => 0
  field :state,        :type => String,  :default => "new"

  field :last_post_id
  field :last_updated_at, :type => DateTime
  field :last_forum_user_id

  field :audited, :type => String, :default => "new"

  referenced_in :forum_user
  referenced_in :forum
  references_many :posts
  # forum user can monitor topics
  references_and_referenced_in_many :forum_users


end