before "deploy:finalize_update", "leaderboard-grape-rainbows:bundle:install"

namespace 'leaderboard-grape-rainbows' do
  namespace :bundle do
    task :install do
      run "cd #{release_path}/leaderboard-grape-rainbows; bundle install --path #{shared_path}/bundle --deployment --quiet --without development test"
    end
  end
end
