class CreateAppScoreStats < ActiveRecord::Migration
  def self.up
    create_table :app_score_stats do |t|
      t.integer :age_group
      t.integer :total_score,:default=>0
      t.integer :total_times,:default=>0
      t.integer :client_application_id
      t.string :app_type
      t.timestamps
    end

    add_index :app_score_stats, :app_type
    add_index :app_score_stats, [:client_application_id,:age_group],:name=>"index_app_age_group", :unique => true
  end

  def self.down
    drop_table :app_score_stats
  end
end
