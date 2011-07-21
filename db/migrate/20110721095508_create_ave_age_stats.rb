class CreateAveAgeStats < ActiveRecord::Migration
  def self.up
    create_table :ave_age_stats do |t|
      t.integer :user_id, :null => false
      t.string  :developer_name
      t.integer :app_id,  :null => false
      t.string  :app_name
      t.integer :ave_age
      t.integer :player_amount
      t.date    :current_day
      t.timestamps
    end
  end

  def self.down
  end
end
