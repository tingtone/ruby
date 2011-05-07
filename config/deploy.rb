set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.2-p180@kittypad/server'
set :rvm_type, :user

set :application, "kittypad_server"
set :repository,  "git@github.com:kittypad/ruby.git"

set :scm, :git
set :deploy_via, :remote_cache
set :user, 'deploy'
set :use_sudo, false

role :web, "ec2-50-16-134-27.compute-1.amazonaws.com"
role :app, "ec2-50-16-134-27.compute-1.amazonaws.com"
role :db,  "ec2-50-16-134-27.compute-1.amazonaws.com", :primary => true

after "deploy:update_code", "config:init"

namespace :config do
  task :init do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
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
