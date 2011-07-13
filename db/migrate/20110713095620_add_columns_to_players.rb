class AddColumnsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :time_left, :integer
    add_column :players, :timestamp, :integer
  end

  def self.down
    remove_column :players, :time_left
    remove_column :players, :timestamp
  end
end
