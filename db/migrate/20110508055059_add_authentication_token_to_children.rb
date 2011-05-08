class AddAuthenticationTokenToChildren < ActiveRecord::Migration
  def self.up
    add_column :children, :authentication_token, :string
  end

  def self.down
    remove_column :children, :authentication_token
  end
end
