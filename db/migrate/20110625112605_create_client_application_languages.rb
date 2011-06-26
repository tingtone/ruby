class CreateClientApplicationLanguages < ActiveRecord::Migration
  def self.up
    create_table :client_application_languages do |t|
      t.integer :client_application_id
      t.integer :language_id

      t.timestamps
    end
  end

  def self.down
    drop_table :client_application_languages
  end
end
