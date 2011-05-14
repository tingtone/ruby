class ScoreTracker < ActiveRecord::Base
  belongs_to :child
  belongs_to :client_application
  validates_presence_of :score
  validates_numericality_of :score

  before_save :check_score_count

  protected
    def check_score_count
      sum = ScoreTracker.sum(:score, :conditions => {:child_id => child.id, :client_application_id => client_application.id})
      if client_application.max_score < sum + score
        self.errors.add(:score, "can't add to this child any more")
        false
      end
    end
end
