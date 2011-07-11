class CreateFavoriteAppsWeekTrackers < ActiveRecord::Migration
  def self.up
    create_table :favorite_apps_week_trackers do |t|
      t.integer :player_id,  :null => false
      t.integer :app_id, :null => false
      t.integer :total_time
      t.date  :start_day
      t.date  :end_day
      t.timestamps
    end
  end

  def self.down
  end
end
