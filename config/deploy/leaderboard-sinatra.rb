before "deploy:finalize_update", "leaderboard-sinatra:bundle:install"

namespace 'leaderboard-sinatra' do
  namespace :bundle do
    task :install do
      run "cd #{release_path}/leaderboard-sinatra; bundle install --path #{shared_path}/bundle --deployment --quiet --without development test"
    end
  end
end
