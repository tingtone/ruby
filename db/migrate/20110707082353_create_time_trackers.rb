class CreateTimeTrackers < ActiveRecord::Migration
  def self.up
    create_table :time_trackers do |t|
      t.integer :time,      :default => 0
      t.integer :player_id, :null    => false
      t.integer :app_id,    :null    => false
      t.timestamps
    end
  end

  def self.down
    drop_table :time_trackers
  end
end
