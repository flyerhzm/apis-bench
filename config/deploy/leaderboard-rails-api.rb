before "deploy:finalize_update", "leaderboard-rails-api:bundle:install"

namespace 'leaderboard-rails-api' do
  namespace :bundle do
    task :install do
      run "cd #{release_path}/leaderboard-rails-api; bundle install --path #{shared_path}/bundle --deployment --quiet --without development test"
    end
  end
end
