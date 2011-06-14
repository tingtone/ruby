class AddChildrenUpdatedAtToParents < ActiveRecord::Migration
  def self.up
    add_column :parents, :children_updated_at, :datetime
  end

  def self.down
    remove_column :parents, :children_updated_at
  end
end
