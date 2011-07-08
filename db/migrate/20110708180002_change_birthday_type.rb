class ChangeBirthdayType < ActiveRecord::Migration
  def self.up
    change_column :players, :birthday, :date
  end

  def self.down
  end
end
