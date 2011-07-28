class AddIconPathToApp < ActiveRecord::Migration
  def self.up
    add_column :apps, :icon_path, :string
    change_column :apps, :price, :string
  end

  def self.down
  end
end
