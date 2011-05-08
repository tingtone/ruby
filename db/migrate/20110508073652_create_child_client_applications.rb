class CreateChildClientApplications < ActiveRecord::Migration
  def self.up
    create_table :child_client_applications do |t|
      t.integer :child_id
      t.integer :client_application_id
      t.integer :time

      t.timestamps
    end
  end

  def self.down
    drop_table :child_client_applications
  end
end
