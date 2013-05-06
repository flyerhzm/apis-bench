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

template "/etc/nginx/sites-available/leaderboard-rails" do
  source "leaderboard-rails.nginx.conf"
end

link "/etc/nginx/sites-enabled/leaderboard-rails" do
  to "/etc/nginx/sites-available/leaderboard-rails"
end

template "/tmp/leaderboard-rails.god" do
  source "leaderboard-rails.god"
end

template "/tmp/god.conf" do
  source "god.conf"
end

template "/etc/nginx/sites-available/leaderboard-rails-api" do
  source "leaderboard-rails-api.nginx.conf"
end

link "/etc/nginx/sites-enabled/leaderboard-rails-api" do
  to "/etc/nginx/sites-available/leaderboard-rails-api"
end

template "/tmp/leaderboard-rails-api.god" do
  source "leaderboard-rails-api.god"
end

template "/tmp/god.conf" do
  source "god.conf"
end

execute "god_start" do
  command "rvmsudo god -c /tmp/god.conf"
end
