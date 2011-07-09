class ChangeExchangeAppType < ActiveRecord::Migration
  def self.up
    change_column :users, :exchange_app, :integer
  end

  def self.down
  end
end
