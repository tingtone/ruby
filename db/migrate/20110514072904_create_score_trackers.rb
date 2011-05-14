class CreateScoreTrackers < ActiveRecord::Migration
  def self.up
    create_table :score_trackers do |t|
      t.integer :child_id
      t.integer :client_application_id
      t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :score_trackers
  end
end
