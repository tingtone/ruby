class Parent::AgeGradesController < Parent::BaseController
  def index
    @age_grades = AgeGrade.order("created_at desc").limit(11)
  end
end
