class CreateAppStatTimeSlot < ActiveRecord::Migration
  def self.up
    create_table :app_stat_time_slots do |t|
      t.integer :span
      t.integer :timetag
      t.integer :sum_time,:default=>0
      t.integer :total_times,:default=>0
      t.integer :client_application_id
      t.string :app_type
      t.timestamps
    end

    add_index :app_stat_time_slots, :app_type
    add_index :app_stat_time_slots, [:client_application_id,:span,:timetag],:name=>"index_app_slot_time_span"
  end

  def self.down
    drop_table :app_stat_time_slots
  end

end
