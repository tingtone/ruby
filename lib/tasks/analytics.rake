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
end
