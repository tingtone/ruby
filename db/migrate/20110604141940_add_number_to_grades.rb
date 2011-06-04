class AddNumberToGrades < ActiveRecord::Migration
  def self.up
    add_column :grades, :number, :integer
  end

  def self.down
    remove_column :grades, :number
  end
end
