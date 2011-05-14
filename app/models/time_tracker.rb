class TimeTracker < ActiveRecord::Base
  belongs_to :child
  belongs_to :client_application
  validates_presence_of :time
  validates_numericality_of :time
end
