class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :user_id, :null => false
      t.string  :device_identifier
      t.string  :device_user_agent
      t.string  :language
      
      t.string  :name
      t.string  :gender
      t.datetime  :birthday
      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
