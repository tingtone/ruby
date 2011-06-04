task :analytics => ['analytics:education_application:most_played', 'analytics:children:age_grades']

namespace :analytics do
  namespace :education_application do
    desc "most played education applications"
    task :most_played => :environment do
      results = EducationApplication.joins(:time_trackers).order('sum_time desc').limit(10).group(:client_application_id).sum(:time)
      results.each do |id, time|
        MostPlayed.create(:client_application => EducationApplication.find(id), :time => time)
      end
    end
  end

  namespace :children do
    desc "average grades for all children"
    task :age_grades => :environment do
      (2..12).each do |age|
        grade_number = Achievement.joins(:grade, :child).where("year(birthday) = ?", Date.today.year - age).average(:number)
        grade = Grade.find_by_number(grade_number || 1)
        AgeGrade.create(:age => age, :grade => grade)
      end
    end
  end
end
