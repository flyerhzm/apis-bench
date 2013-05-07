before "deploy:finalize_update", "leaderboard-grape-goliath:bundle:install"

namespace 'leaderboard-grape-goliath' do
  namespace :bundle do
    task :install do
      run "cd #{release_path}/leaderboard-grape-goliath; bundle install --path #{shared_path}/bundle --deployment --quiet --without development test"
    end
  end
end
