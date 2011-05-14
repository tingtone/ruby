class RenameChildClientApplicationsToTimeTrackers < ActiveRecord::Migration
  def self.up
    rename_table :child_client_applications, :time_trackers
  end

  def self.down
    rename_table :time_trackers, :child_client_applications
  end
end
