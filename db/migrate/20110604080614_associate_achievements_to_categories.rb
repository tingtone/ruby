class AssociateAchievementsToCategories < ActiveRecord::Migration
  def self.up
    add_column :achievements, :client_application_category_id, :integer
    remove_column :achievements, :course
    change_column :achievements, :score, :integer, :default => 0, :nil => false
  end

  def self.down
    change_column :achievements, :score, :integer
    add_column :achievements, :course, :string
    remove_column :achievements, :client_application_category_id
  end
end
