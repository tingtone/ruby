class CreatePlayerApps < ActiveRecord::Migration
  def self.up
    create_table :player_apps do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :player_apps
  end
end
