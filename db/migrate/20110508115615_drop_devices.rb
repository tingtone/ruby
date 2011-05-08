class DropDevices < ActiveRecord::Migration
  def self.up
    drop_table :devices
  end

  def self.down
  end
end
