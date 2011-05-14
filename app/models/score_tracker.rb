class ScoreTracker < ActiveRecord::Base
  belongs_to :child
  belongs_to :client_application
  validates_presence_of :score
  validates_numericality_of :score
end
