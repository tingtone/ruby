class AddScreenshotColumnsToClientApplications < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :screenshot_file_name,    :string
    add_column :client_applications, :screenshot_content_type, :string
    add_column :client_applications, :screenshot_file_size,    :integer
    add_column :client_applications, :screenshot_updated_at,   :datetime
  end

  def self.down
    remove_column :client_applications, :screenshot_updated_at
    remove_column :client_applications, :screenshot_file_size
    remove_column :client_applications, :screenshot_content_type
    remove_column :client_applications, :screenshot_file_name
  end
end
