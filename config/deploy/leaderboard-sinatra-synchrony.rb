before "deploy:finalize_update", "leaderboard-sinatra-synchrony:bundle:install"

namespace 'leaderboard-sinatra-synchrony' do
  namespace :bundle do
    task :install do
      run "cd #{release_path}/leaderboard-sinatra-synchrony; bundle install --path #{shared_path}/bundle --deployment --quiet --without development test"
    end
  end
end
