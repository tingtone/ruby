class RemoveClientSaltFromParents < ActiveRecord::Migration
  def self.up
    remove_column :parents, :client_salt
  end

  def self.down
  end
end
