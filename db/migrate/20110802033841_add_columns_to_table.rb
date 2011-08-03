class AddColumnsToTable < ActiveRecord::Migration
  def self.up
    add_column :players, :rental, :decimal, :precision => 8, :scale => 2, :default => 0.99
    add_column :apps, :unite_pay, :boolean, :default => false
  end

  def self.down
  end
end
