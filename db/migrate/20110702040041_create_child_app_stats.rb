class CreateChildAppStats < ActiveRecord::Migration
  def self.up
    create_table :child_app_stats,:force=>true do |t|
      t.integer :child_id
      t.integer :sum_time,:default=>0
      t.integer :total_times,:default=>0
      t.integer :client_application_id
      t.string :app_type
      t.timestamps
    end

    add_index :child_app_stats, :app_type
    add_index :child_app_stats, [:child_id,:client_application_id], :name=>"index_child_app_uniq" , :unique => true
    add_index :child_app_stats, :child_id
  end

  def self.down
    drop_table :child_app_stats
  end
end
