class AddParentIdToChildren < ActiveRecord::Migration
  def self.up
    add_column :children, :parent_id, :integer
  end

  def self.down
    remove_column :children, :parent_id
  end
end
