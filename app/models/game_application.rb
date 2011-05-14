class GameApplication < ClientApplication
  RATINGS = [4, 9, 12]

  has_many :rule_definitions, :foreign_key => 'client_application_id'

  accepts_nested_attributes_for :rule_definitions
end
