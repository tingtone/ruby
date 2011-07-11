class CreateCategoriesTimePercentWeek < ActiveRecord::Migration
  def self.up
    create_table :categories_time_percent_weeks do |t|
      t.integer :player_id,  :null => false
      t.integer :category_id, :null => false
      t.integer :time
      t.integer :total_time
      t.date  :start_day
      t.date  :end_day
      t.timestamps
    end
  end

  def self.down
  end
end
