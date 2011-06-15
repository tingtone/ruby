class Forum
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Mongoid::Acts::Tree

  
  cache
  
  #fields
  field :name
  field :description
  field :topics_count, :type => Integer, :default => 0
  field :posts_count,  :type => Integer, :default => 0
  field :position,     :type => Integer, :default => 0
  field :state,        :type => String,  :default => "public"
  
  acts_as_tree
  references_many :topics
  references_many :posts
  
  # Setting Moderator for Forum
  references_and_referenced_in_many :forum_users
  
  scope :ordered_forums, all.asc(:position)
  
end