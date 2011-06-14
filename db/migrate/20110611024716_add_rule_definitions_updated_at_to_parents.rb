class AddRuleDefinitionsUpdatedAtToParents < ActiveRecord::Migration
  def self.up
    add_column :parents, :rule_definitions_updated_at, :datetime
  end

  def self.down
    remove_column :parents, :rule_definitions_updated_at
  end
end
