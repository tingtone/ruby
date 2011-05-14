class AddTotalTimeToParents < ActiveRecord::Migration
  def self.up
    add_column :parents, :total_time, :integer
  end

  def self.down
    remove_column :parents, :total_time
  end
end
