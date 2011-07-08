class CreateTopTens < ActiveRecord::Migration
  def self.up
    create_table :top_tens do |t|
      t.integer :app_id, :null => false
      t.integer :amount, :default => 0
      t.integer :time,   :default => 0
      t.string  :type
      t.timestamps
    end
  end

  def self.down
    drop_table :top_tens
  end
end
