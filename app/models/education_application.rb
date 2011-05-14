class EducationApplication < ClientApplication
  DEFAULT_MAX_SCORE = 500

  before_save :set_max_score

  protected
    def set_max_score
      self.max_score = DEFAULT_MAX_SCORE
    end
end
