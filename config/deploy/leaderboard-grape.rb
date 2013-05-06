before "deploy:finalize_update", "leaderboard-grape:bundle:install"

namespace 'leaderboard-grape' do
  namespace :bundle do
    task :install do
      run "cd #{release_path}/leaderboard-grape; bundle install --path #{shared_path}/bundle --deployment --quiet --without development test"
    end
  end
end
