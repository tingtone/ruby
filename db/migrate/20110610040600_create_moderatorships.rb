class CreateModeratorships < ActiveRecord::Migration
   def self.up
    create_table :moderatorships do |t|
      t.integer  :parent_id
      t.integer  :forum_id
      t.timestamps
    end

    add_index "moderatorships", ["parent_id", "forum_id"],  :name => "index_moderatorships_on_forum_id_and_parent_id"
    add_index "moderatorships", ["forum_id"],  :name => "index_moderatorships_on_forum_id"

  end

  def self.down
    drop_table :moderatorships
  end
end
