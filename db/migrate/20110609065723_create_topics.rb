class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.integer  :forum_id
      t.integer  :parent_id
      t.string   :title

      t.integer  :hits,            :default => 0
      t.integer  :sticky,          :default => 0
      t.integer  :posts_count,     :default => 0
      t.boolean  :locked,          :default => false
      t.integer  :last_post_id
      t.datetime :last_updated_at
      t.integer  :last_user_id
      t.string   :permalink

      t.timestamps
    end
    
    add_index "topics", ["forum_id", "permalink"], :name => "index_topics_on_forum_id_and_permalink"
    add_index "topics", ["last_updated_at", "forum_id"], :name => "index_topics_on_forum_id_and_last_updated_at"
    add_index "topics", ["sticky", "last_updated_at", "forum_id"], :name => "index_topics_on_sticky_and_last_updated_at"
    
  end

  def self.down
    drop_table :topics
  end
end
