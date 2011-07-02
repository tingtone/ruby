class CreateChildScoreStats < ActiveRecord::Migration
  def self.up
    create_table :stats_child_score_stats do |t|
      t.integer :child_id
      t.integer :client_application_id
      t.integer :total_score,:default=>0
      t.integer :total_times,:default=>0
      t.integer :timetag
      t.integer :span
      t.string :app_type
      t.integer :age_group
      t.timestamps
    end

    add_index :stats_child_score_stats, :child_id
  end

  def self.down
    drop_table :stats_child_score_stats
  end
end
