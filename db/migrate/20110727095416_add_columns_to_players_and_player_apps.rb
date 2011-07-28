class AddColumnsToPlayersAndPlayerApps < ActiveRecord::Migration
  def self.up
    add_column :player_apps, :payment_method, :string
    add_column :player_apps, :payment_timestamp, :integer
    add_column :players, :expired_timestamp, :integer
  end

  def self.down
  end
end
