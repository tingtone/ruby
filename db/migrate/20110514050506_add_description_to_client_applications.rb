class AddDescriptionToClientApplications < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :description, :text
  end

  def self.down
    remove_column :client_applications, :description
  end
end
