class CreateTimeTrackers < ActiveRecord::Migration
  def self.up
    create_table :time_trackers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :time_trackers
  end
end
