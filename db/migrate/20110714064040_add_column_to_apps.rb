class AddColumnToApps < ActiveRecord::Migration
  def self.up
    add_column :apps, :language, :string
  end

  def self.down
    remove_column :apps, :language
  end
end
