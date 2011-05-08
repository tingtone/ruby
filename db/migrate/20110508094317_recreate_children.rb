class RecreateChildren < ActiveRecord::Migration
  def self.up
    drop_table :children
    create_table :children do |t|
      t.string :fullname
      t.string :gender
      t.date :birthday
      t.integer :parent_id
    end
  end

  def self.down
  end
end
