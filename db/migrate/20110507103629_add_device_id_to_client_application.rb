class AddDeviceIdToClientApplication < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :device_id, :integer
  end

  def self.down
    remove_column :client_applications, :device_id
  end
end
