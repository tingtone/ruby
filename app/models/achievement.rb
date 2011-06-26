class Achievement < ActiveRecord::Base
  belongs_to :child
  belongs_to :grade
  belongs_to :category

  def grade_name
    grade.try(:name)
  end

  def as_json(options={})
    {:course => course, :score => score, :grade_name => grade_name}
  end
end
