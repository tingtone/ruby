class AddNameColumnToParents < ActiveRecord::Migration
  def self.up
    add_column :parents, :name, :string
  end

  def self.down
    add_column :parents, :name, :string
  end
end
