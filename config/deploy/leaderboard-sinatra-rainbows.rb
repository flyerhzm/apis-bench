before "deploy:finalize_update", "leaderboard-sinatra-rainbows:bundle:install"

namespace 'leaderboard-sinatra-rainbows' do
  namespace :bundle do
    task :install do
      run "cd #{release_path}/leaderboard-sinatra-rainbows; bundle install --path #{shared_path}/bundle --deployment --quiet --without development test"
    end
  end
end
