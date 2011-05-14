class AddClientAppliationCategoryIdToClientApplications < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :client_application_category_id, :integer
  end

  def self.down
    remove_column :client_applications, :client_application_category_id
  end
end
