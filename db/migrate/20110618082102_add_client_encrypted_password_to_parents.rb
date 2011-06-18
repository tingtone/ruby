class AddClientEncryptedPasswordToParents < ActiveRecord::Migration
  def self.up
    add_column :parents, :client_encrypted_password, :string
  end

  def self.down
    remove_column :parents, :client_encrypted_password
  end
end
