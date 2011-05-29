class RuleDefinitionAssociateToChild < ActiveRecord::Migration
  def self.up
    add_column :rule_definitions, :child_id, :integer
    RuleDefinition.all.each do |rule_definition|
      rule_definition.child = Parent.find(rule_definition.parent_id).children.first
      rule_definition.save
    end
    remove_column :rule_definitions, :parent_id
  end

  def self.down
    add_column :rule_definitions, :parent_id
    RuleDefinition.all.each do |rule_definition|
      rule_definition.child = Parent.find(rule_definition.child_id).children.first
      rule_definition.save
    end
    remove_column :rule_definitions, :child_id
  end
end
