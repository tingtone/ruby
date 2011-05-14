class CreateRuleDefinitions < ActiveRecord::Migration
  def self.up
    create_table :rule_definitions do |t|
      t.integer :time
      t.string :period
      t.integer :client_application_id
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rule_definitions
  end
end
