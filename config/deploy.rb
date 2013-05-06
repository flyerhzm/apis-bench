set :rvm_ruby_string, 'ruby-2.0.0-p0'
require 'rvm/capistrano'

set :application, "apis-bench"
set :repository,  "git://github.com/flyerhzm/apis-bench.git"

set :scm, :git
set :use_sudo, false
set :user, 'deploy'
set :deploy_to, '/home/deploy/sites/apis-bench'

role :web, "192.168.0.167"
role :app, "192.168.0.167"
role :db,  "192.168.0.167", :primary => true

after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "rvmsudo god restart leaderboard-rails.unicorn"
    run "rvmsudo god restart leaderboard-rails-api.unicorn"
  end
end
