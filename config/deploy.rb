set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'bundler/capistrano'
set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { stage }
require "whenever/capistrano"

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'

set :rvm_ruby_string, 'ruby-1.9.2-p180@kittypad/server'
set :rvm_type, :user

set :application, "kittypad_server"
set :domain,      "ec2-50-16-134-27.compute-1.amazonaws.com"
set :deploy_to, "/home/deploy/sites/kittypad.com/staging"

set :deploy_via,    :remote_cache
set :copy_strategy, :checkout
set :user,          'deploy'
set :use_sudo, false

set :scm, :git
set :repository, "git@github.com:kittypad/ruby.git"
set :branch, "master"

role :web, "#{domain}"
role :app, "#{domain}"
role :db, "#{domain}", :primary => true

after "deploy:update_code", "config:init"

namespace :config do
  task :init do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/sdk #{release_path}/public/sdk"
  end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    migrate
    cleanup
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end 
end

namespace :logs do
  desc "tail -f production.log"
  task :watch do
    stream("tail -f #{current_release}/log/production.log")
  end
end
