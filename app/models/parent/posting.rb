class Parent
  # Creates new topic and post.
  # Only..
  #  - sets sticky/locked bits if you're a moderator or admin 
  #  - changes forum_id if you're an admin
  #
  def post(forum, attributes)
    attrs = attributes.to_hash.symbolize_keys
    Topic.new(attributes) do |topic|
      topic.forum = forum
      topic.parent  = self
      revise_topic topic, attributes, moderator_of?(forum)
    end
  end

  def reply(topic, body)
    topic.posts.build(:body => body).tap do |post|
      post.forum = topic.forum
      post.parent  = self
      post.save
    end
  end
  
  def revise(record, attributes)
    is_moderator = moderator_of?(record.forum)
    return unless record.editable_by?(self, is_moderator)
    case record
      when Topic then revise_topic(record, attributes, is_moderator)
      when Post  then post.save
      else raise "Invalid record to revise: #{record.class.name.inspect}"
    end
    record
  end

#  def seen!
#    now = Time.now.utc
#    self.class.update_all ['last_seen_at = ?', now], ['id = ?', id]
#    write_attribute :last_seen_at, now
#  end

protected
  def revise_topic(topic, attributes, is_moderator)
    topic.title = attributes[:title] if attributes.key?(:title)
    topic.sticky, topic.locked = attributes[:sticky], attributes[:locked] if is_moderator
    topic.save
  end
end
