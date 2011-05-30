class RemoveTotalTimeFromChildren < ActiveRecord::Migration
  def self.up
    remove_column :children, :total_time
  end

  def self.down
    add_column :children, :total_time, :integer
  end
end
