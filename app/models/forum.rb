# 
#  forum.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Forum
  include Shared::Mongoid
  include Shared::Mongoid::ActTree

  cache
  
  #fields
  field :name
  field :description
  field :topics_count, :type => Integer, :default => 0
  field :posts_count,  :type => Integer, :default => 0
  field :position,     :type => Integer, :default => 0
  field :state,        :type => String,  :default => "public"
  
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
      case typee
      when Search::SEARCH_TYPE[0]
        #Search by Topic and Post
        @topic_titles = Topic.where(title: /.*#{keywords}?/i)
        @topic_contents = Topic.where(content: /.*#{keywords}?/i)
        @posts  = Post.where(content: /.*#{keywords}?/i)
        results = []
        results << @topic_titles unless @topic_titles.blank?
        results << @topic_contents unless @topic_contents.blank?
        results << @posts unless @posts.blank?
        return results
      when Search::SEARCH_TYPE[1]
        # search by User
        @author = ForumUser.first(conditions: {name: keywords})
        return @author.try(:topics)
      else
        #Search by Apps
      end
    end
  end
end