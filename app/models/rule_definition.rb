class RuleDefinition < ActiveRecord::Base
  PERIODS = {
    :day => 30,
    :week => 60
  }
  GLOBAL_PERIODS = {
    :day => 120,
    :week => 240
  }

  belongs_to :client_application
  belongs_to :child

  validates_presence_of :time, :period
  validates_numericality_of :time

  def period=(period)
    write_attribute(:period, period)
    if client_application.blank?
      write_attribute(:time, GLOBAL_PERIODS[self.period.to_sym]) unless self.time
    else
      write_attribute(:time, PERIODS[self.period.to_sym]) unless self.time
    end
  end
end
