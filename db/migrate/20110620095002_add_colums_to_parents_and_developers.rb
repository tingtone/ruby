class AddColumsToParentsAndDevelopers < ActiveRecord::Migration
  def self.up
    add_column :parents, :from_forum, :boolean, :default => false
    add_column :developers, :company_name, :string
  end

  def self.down
  end
end
