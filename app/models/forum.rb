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
  
  def sticky_topics
    topics.asc(:position).select{|t| t if t.sticky == 1}
  end
  
  def common_topics
    topics.desc(:created_at).select{|t| t if t.sticky == 0}
  end
  
  class << self
    def search(keywords, typee)
      if typee == 'Topic'
        @topic_titles = Topic.where(title: /.*#{keywords}?/i)
        @topic_contents = Topic.where(content: /.*#{keywords}?/i)
        @posts  = Post.where(content: /.*#{keywords}?/i)
        results = []
        results << @topic_titles unless @topic_titles.blank?
        results << @topic_contents unless @topic_contents.blank?
        results << @posts unless @topics.blank?
        return results
      else
        #Search Apps
      end
    end
  end
end