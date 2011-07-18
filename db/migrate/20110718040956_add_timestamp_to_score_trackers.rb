class AddTimestampToScoreTrackers < ActiveRecord::Migration
  def self.up
    add_column :score_trackers, :timestamp, :integer
  end

  def self.down
    remove_column :score_trackers, :timestamp
  end
end
