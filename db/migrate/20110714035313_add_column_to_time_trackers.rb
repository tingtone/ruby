class AddColumnToTimeTrackers < ActiveRecord::Migration
  def self.up
    add_column :time_trackers, :timestamp, :integer
  end

  def self.down
    remove_column :time_trackers, :timestamp
  end
end
