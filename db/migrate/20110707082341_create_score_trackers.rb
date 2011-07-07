class CreateScoreTrackers < ActiveRecord::Migration
  def self.up
    create_table :score_trackers do |t|
      t.integer :score,     :default => 0
      t.integer :player_id, :null    => false
      t.integer :app_id,    :null    => false
      t.timestamps
    end
  end

  def self.down
    drop_table :score_trackers
  end
end
