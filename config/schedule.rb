# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "/home/deploy/sites/kittypad.com/staging/shared/log/cron_log.log"
job_type :rake, "cd :path && RAILS_ENV=:environment bundle exec rake :task :output"
job_type :thor, "cd :path && RAILS_ENV=:environment bundle exec thor :task :output"


every 1.day, :at => '01:00 am' do
  thor "statistics:install_apps_day_tracker"
end

every 1.day, :at => '01:00 am' do
  thor "statistics:most_active"
end

every :monday, :at => "01:00 am" do
  thor "statistics:favorite_apps_week_trackers"
end

every :monday, :at => "01:00 am" do
  thor "statistics:categories_time_percent_weeks"
end

# for developer stats
every 1.day, :at => '01:00 am' do
  thor "statistics:active_amount"
  thor "statistics:average_age "
  thor "statistics:most_gender"
end
