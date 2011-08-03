class AddSomeColumnsToApps < ActiveRecord::Migration
  def self.up
    add_column :apps, :change_times, :integer, :default => 0
    add_column :apps, :show_times, :integer, :default => 0
    add_column :apps, :left_show_times, :integer, :default => 0
  end

  def self.down
  end
end
