set :rails_env, "staging"
set :repository,  "git@github.com:kittypad/ruby.git"
set :scm,         "git"
set :branch, "feature/forum"
set :deploy_to, "/home/deploy/sites/kittypad.com/staging"

set :user, 'deploy'
set :use_sudo,    false
set :deploy_via, :copy