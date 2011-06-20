class AddClientSaltToParents < ActiveRecord::Migration
  def self.up
    add_column :parents, :client_salt, :string
  end

  def self.down
    remove_column :parents, :client_salt
  end
end
