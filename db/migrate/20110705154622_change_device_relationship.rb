class ChangeDeviceRelationship < ActiveRecord::Migration
  def self.up
    #remove_column :devices, :parent_id
    add_column :devices, :player_id, :integer
    add_column :devices, :account_id, :integer
  end

  def self.down
    remove_column :devices, :account_id
    remove_column :devices, :player_id
    add_column :devices, :parent_id
  end
end
