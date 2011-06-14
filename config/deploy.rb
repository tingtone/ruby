set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'

before :deploy do
  unless exists?(:deploy_to)
    raise "Please invoke me like `cap stage deploy` where stage is production/staging"
  end
end

set :rvm_ruby_string, 'ruby-1.9.2-p180@kittypad/server'
set :rvm_type, :user

set :application, "kittypad_server"
set :domain,      "ec2-50-16-134-27.compute-1.amazonaws.com"
set :deploy_to, "/home/deploy/sites/kittypad.com/staging"

role :web, "#{domain}"
role :app, "#{domain}"

#task :staging do
#  set :deploy_to, "/home/deploy/sites/kittypad.com/staging"
#  after('deploy:symlink', 'cruise_control:build')
#end

namespace :passenger do

  desc "Start Passenger Application"
  task :start, :roles => :app do
    run "touch #{release_path}/tmp/restart.txt"
  end

  desc "Restart Passenger Application"
  task :restart, :roles => :app do
    run "touch #{release_path}/tmp/restart.txt"
  end

end

namespace :logs do
  desc "tail -f production.log"
  task :watch do
    stream("tail -f #{release_path}/log/production.log")
  end
end


puts "deploy to #{release_path}"


#step by step
#cap deploy:setup
#cap deploy:check
#cap deploy



