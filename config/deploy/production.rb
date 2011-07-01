set :rails_env, :production
set :deploy_to, "/home/deploy/sites/kittypad.com/production"

set :deploy_via,    :copy
set :copy_strategy, :checkout
set :user,          'deploy'
set :use_sudo, false
#set :keep_releases, 3cd ..

set :scm, :git
set :repository, "git@github.com:kittypad/ruby.git"
set :branch, "master"



