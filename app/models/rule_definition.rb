class RuleDefinition < ActiveRecord::Base
  PERIODS = {
    :day => 30,
    :week => 60
  }

  belongs_to :client_application
  belongs_to :child

  validates_presence_of :time, :period
  validates_numericality_of :time

  def period=(period)
    write_attribute(:period, period)
    write_attribute(:time, PERIODS[self.period.to_sym]) unless self.time
  end
end
