class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer   :user_id, :null => false
      t.string    :device_identifier
      t.string    :device_user_agent
      t.string    :language
      
      t.string    :name
      t.string    :gender
      t.datetime  :birthday
      
      t.string    :avatar_file_name
      t.string    :avatar_content_type
      t.string    :avatar_file_size
      t.datetime  :avatar_updated_at
      
      t.integer   :time_between_pause
      t.integer   :pause_duration
      t.integer   :time_between_breaks
      t.integer   :break_duration
      t.integer   :time_to_pause
      t.integer   :time_to_break
      t.integer   :weekday_time
      t.integer   :weekend_time
      
      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
