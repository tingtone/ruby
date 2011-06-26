class AddCategoryAssociationToAchievements < ActiveRecord::Migration
  def self.up
    add_column :achievements, :category_id, :integer
    remove_column :achievements, :client_application_category_id
  end

  def self.down
    add_column :achievements, :client_application_category_id, :integer
    remove_column :achievements, :category_id
  end
end
