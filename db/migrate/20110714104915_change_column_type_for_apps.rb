class ChangeColumnTypeForApps < ActiveRecord::Migration
  def self.up
    change_column :apps, :language, :text
  end

  def self.down
  end
end
