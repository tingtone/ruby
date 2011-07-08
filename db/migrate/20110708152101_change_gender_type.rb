class ChangeGenderType < ActiveRecord::Migration
  def self.up
    change_column :players, :gender, :integer
  end

  def self.down
  end
end
