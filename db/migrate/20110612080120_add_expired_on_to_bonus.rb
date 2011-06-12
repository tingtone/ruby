class AddExpiredOnToBonus < ActiveRecord::Migration
  def self.up
    add_column :bonus, :expired_on, :date
  end

  def self.down
    remove_column :bonus, :expired_on
  end
end
