class Grade < ActiveRecord::Base
  has_many :achievements

  scope :by_score, lambda { |score|
    {:conditions => ["min_score <= ? and max_score >= ?", score, score]}
  }
end
