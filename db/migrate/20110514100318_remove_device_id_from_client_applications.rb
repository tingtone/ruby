class RemoveDeviceIdFromClientApplications < ActiveRecord::Migration
  def self.up
    remove_column :client_applications, :device_id
  end

  def self.down
    add_column :client_applications, :device_id, :integer
  end
end
