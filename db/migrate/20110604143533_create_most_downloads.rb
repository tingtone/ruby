class CreateMostDownloads < ActiveRecord::Migration
  def self.up
    create_table :most_downloads do |t|
      t.integer :client_application_id
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :most_downloads
  end
end
