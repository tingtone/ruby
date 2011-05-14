class AddTypeToClientApplications < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :type, :string
  end

  def self.down
    remove_column :client_applications, :type
  end
end
