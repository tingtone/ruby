class CreateParentClientApplications < ActiveRecord::Migration
  def self.up
    create_table :parent_client_applications do |t|
      t.integer :parent_id
      t.integer :client_application_id

      t.timestamps
    end
  end

  def self.down
    drop_table :parent_client_applications
  end
end
