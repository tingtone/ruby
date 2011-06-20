class AddStartAgeAndEndAgeAndAppStoreUrlToClientApplications < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :start_age, :integer
    add_column :client_applications, :end_age, :integer
    add_column :client_applications, :app_store_url, :string
  end

  def self.down
    remove_column :client_applications, :app_store_url
    remove_column :client_applications, :end_age
    remove_column :client_applications, :start_age
  end
end
