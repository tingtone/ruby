class TimeToChildren < ActiveRecord::Migration
  def self.up
    add_column :children, :total_time, :integer
    Child.all.each do |child|
      child.total_time = child.parent.total_time
      child.save
    end
    remove_column :parents, :total_time
  end

  def self.down
    add_column :parents, :total_time
    Parent.all.each do |parent|
      parent.total_time = parent.children.first.total_time
      parent.save
    end
    remove_column :children, :total_time
  end
end
