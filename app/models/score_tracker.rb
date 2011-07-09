class ScoreTracker < ActiveRecord::Base
  belongs_to :player
  belongs_to :app
  belongs_to :category
end
