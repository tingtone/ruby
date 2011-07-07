class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string   :name
      t.string   :key
      t.string   :secret
      t.integer  :user_id,     :null => false
      t.text     :description
      t.integer  :category_id, :null => false
      t.string   :rating
      t.string   :support_device
      t.string   :max_score
      t.string   :app_store_url
      t.string   :screenshot_file_name
      t.string   :screenshot_content_type
      t.integer  :screenshot_file_size
      t.datetime :screenshot_updated_at
      
      t.string   :icon_file_name
      t.string   :icon_content_type
      t.integer  :icon_file_size
      t.datetime :icon_updated_at
      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :apps
  end
end
