class AddTimestampToChildren < ActiveRecord::Migration
  def self.up
    add_column :children, :created_at, :datetime
    add_column :children, :updated_at, :datetime
  end

  def self.down
    remove_column :children, :updated_at
    remove_column :children, :created_at
  end
end
