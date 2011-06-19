class AddSubjectToClientApplications < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :subject, :string
  end

  def self.down
    remove_column :client_applications, :subject
  end
end
