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

  def self.globals
    {:game_day_time => PERIODS[:day], :game_week_time => PERIODS[:week], :total_day_time => GLOBAL_PERIODS[:day], :total_week_time => GLOBAL_PERIODS[:week]}
  end

  def self.for_child_client_application(child, client_application)
    results = {}
    RuleDefinition.where(:child_id => child.id, :client_application_id => nil).each do |rule_definition|
      results[:"total_#{rule_definition.period}_time"] = rule_definition.time
    end
    RuleDefinition.where(:child_id => child.id, :client_application_id => client_application.id).each do |rule_definition|
      results[:"game_#{rule_definition.period}_time"] = rule_definition.time
    end
    results
  end

  def period=(period)
    write_attribute(:period, period)
    if client_application.blank?
      write_attribute(:time, GLOBAL_PERIODS[self.period.to_sym]) unless self.time
    else
      write_attribute(:time, PERIODS[self.period.to_sym]) unless self.time
    end
  end
end
