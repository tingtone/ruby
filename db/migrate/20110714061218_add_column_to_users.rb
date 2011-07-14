class AddColumnToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :timestamp, :integer
  end

  def self.down
    remove_column :users, :timestamp
  end
end
