class Parent::AgeGradesController < Parent::BaseController
  def index
    @age_grades = AgeGrade.all
  end
end
