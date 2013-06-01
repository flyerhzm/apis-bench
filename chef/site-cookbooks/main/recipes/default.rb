user_account "deploy" do
  password "$1$5mk003zO$GDCEKOIAsqvm4RDrJMX5Z."
  home "/home/deploy"
  ssh_keys ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2qM48j/fVhoJlXnQ7i4XNj8wE8zpRJMJMT1PllPqCGW/IMdnQfoIw43fHtOCSyoEGmJ9IWtbxQK2/+XkcycIILw1EAfBYw5/DKi9EwvlFmyIe3sj2R9TdJ31Dv7wTlEOkYfY8dSUjSJc8aai2KmmWuvHudL4qhT7yxN4j2pFeoo6ACtnwxgYcrtG2jBeZtSqdW7mWBXZh0SJglo1lyMtZ2gmkqj8tutynZix6pxdAoP8gcQEWOjINxNJe+T+zbxsjkFZg0SrYK/ismO/ZjJvPYmbDMudxQhRyPx+KB4K1yEwn5xgzcnO6su8alXOIxCER7Bh7Bl51td9RaCx3dXdp huangrichard@Huangs-MacBook-Air.local"]
  supports manage_home: true
end

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

mysql_database 'api_bench_production' do
  connection mysql_connection_info
  action :create
end

mysql_database_user 'api-bench' do
  connection mysql_connection_info
  password 'api-bench'
  database_name 'api_bench_production'
  privileges [:all]
  action :grant
end

template "/tmp/leaderboard-rails.god" do
  source "leaderboard-rails.god"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-rails.unicorn.rb" do
  source "leaderboard-rails.unicorn.rb"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-rails-api.god" do
  source "leaderboard-rails-api.god"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-rails-api.unicorn.rb" do
  source "leaderboard-rails-api.unicorn.rb"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-sinatra.unicorn.god" do
  source "leaderboard-sinatra.unicorn.god"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-sinatra.unicorn.rb" do
  source "leaderboard-sinatra.unicorn.rb"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-grape.unicorn.god" do
  source "leaderboard-grape.unicorn.god"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-grape.unicorn.rb" do
  source "leaderboard-grape.unicorn.rb"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-sinatra.rainbows.god" do
  source "leaderboard-sinatra.rainbows.god"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-sinatra.rainbows.rb" do
  source "leaderboard-sinatra.rainbows.rb"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-grape.rainbows.god" do
  source "leaderboard-grape.rainbows.god"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-grape.rainbows.rb" do
  source "leaderboard-grape.rainbows.rb"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-sinatra-synchrony.god" do
  source "leaderboard-sinatra-synchrony.god"
  user 'deploy'
  group 'deploy'
end

template "/tmp/leaderboard-grape-goliath.god" do
  source "leaderboard-grape-goliath.god"
  user 'deploy'
  group 'deploy'
end

template "/tmp/god.conf" do
  source "god.conf"
  user 'deploy'
  group 'deploy'
end
