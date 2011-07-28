class ChangeColumnInApps < ActiveRecord::Migration
  def self.up
    add_column :apps, :rated, :integer
  end

  def self.down
  end
end
