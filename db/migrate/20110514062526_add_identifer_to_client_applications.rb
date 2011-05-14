class AddIdentiferToClientApplications < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :identifier, :string
  end

  def self.down
    remove_column :client_applications, :identifier
  end
end
