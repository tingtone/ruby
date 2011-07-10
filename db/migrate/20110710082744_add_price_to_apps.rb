class AddPriceToApps < ActiveRecord::Migration
  def self.up
    add_column :apps, :price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :apps, :price, :decimal
  end
end
