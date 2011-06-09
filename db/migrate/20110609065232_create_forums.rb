class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.string  :name
      t.string  :description
      t.integer :topics_count,     :default => 0
      t.integer :posts_count,      :default => 0
      t.integer :position,         :default => 0
      t.text    :description_html
      t.string  :state,            :default => "public"
      t.string  :permalink

      t.timestamps
    end
    
    add_index "forums", ["position"], :name => "index_forums_on_position"
    add_index "forums", ["permalink"], :name => "index_forums_on_permalink"
  end

  def self.down
    drop_table :forums
  end
end
