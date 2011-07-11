class CreateInstallAppsDayTrackers < ActiveRecord::Migration
  def self.up
    create_table :install_apps_day_trackers do |t|
      t.integer :player_id,  :null => false
      t.integer :app_id, :null => false
      t.integer :total_time
      t.timestamps
    end
  end

  def self.down
  end
end
