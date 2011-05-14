class RuleDefinition < ActiveRecord::Base
  PERIODS = ['day', 'week']

  belongs_to :client_application
  belongs_to :parent

  validates_presence_of :time, :period
  validates_numericality_of :time
end
