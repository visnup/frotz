set :application, "frotz"
set :scm, "git"
set :repository,  "git://github.com/visnup/frotz.git"
set :deploy_via, :remote_cache

set :user, "app"
set :rails_env, "production"
set :use_sudo, false

role :app, "frotz.jankyteeth.com"
role :web, "frotz.jankyteeth.com"
role :db,  "frotz.jankyteeth.com", :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
