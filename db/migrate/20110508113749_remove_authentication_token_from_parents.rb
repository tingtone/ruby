class RemoveAuthenticationTokenFromParents < ActiveRecord::Migration
  def self.up
    remove_column :parents, :authentication_token
  end

  def self.down
    add_column :parents, :authentication_token
  end
end
