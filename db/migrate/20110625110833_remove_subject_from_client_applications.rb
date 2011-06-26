class RemoveSubjectFromClientApplications < ActiveRecord::Migration
  def self.up
    remove_column :client_applications, :subject
  end

  def self.down
  end
end
