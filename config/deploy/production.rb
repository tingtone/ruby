set :rails_env, :production
set :deploy_to, "/home/deploy/sites/kittypad.com/production"

set :application, "kittypad-server"

set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via,    :copy
set :copy_strategy, :checkout
set :user,          'deploy'
#set :use_sudo, false
set :keep_releases, 3

set :scm, :git
set :repository, "git@github.com:kittypad/server.git"
set :branch, "master"

role :app, "blog.kittypad.com"
role :web, "blog.kittypad.com"
role :db,  "blog.kittypad.com", :primary => true

desc "This is here to overide the original :restart"
deploy.task :restart, :roles => :app do
  # do nothing but overide the default
  powder restart
end


