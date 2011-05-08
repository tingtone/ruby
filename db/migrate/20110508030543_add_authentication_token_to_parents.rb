class AddAuthenticationTokenToParents < ActiveRecord::Migration
  def self.up
    add_column :parents, :authentication_token, :string
    add_index :parents, :authentication_token, :unique => true
  end

  def self.down
    remove_index :parents, :column => :authentication_token
    remove_column :parents, :authentication_token
  end
end
