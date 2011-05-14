class AddAuthenticationTokenToParentsAgain < ActiveRecord::Migration
  def self.up
    add_column :parents, :authentication_token, :string
  end

  def self.down
    remove_column :parents, :authentication_token
  end
end
