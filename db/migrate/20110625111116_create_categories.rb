class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    remove_column :client_applications, :client_application_category_id
    remove_column :client_application_categories, :name
    add_column :client_application_categories, :client_application_id, :integer
    add_column :client_application_categories, :category_id, :integer
  end

  def self.down
    drop_table :categories
  end
end
