before "deploy:finalize_update", "leaderboard-rails:bundle:install"

namespace 'leaderboard-rails' do
  namespace :bundle do
    task :install do
      run "cd #{release_path}/leaderboard-rails; bundle install --path #{shared_path}/bundle --deployment --quiet --without development test"
    end
  end
end
