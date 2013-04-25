user_account "deploy" do
  password "$1$5mk003zO$GDCEKOIAsqvm4RDrJMX5Z."
  home "/home/deploy"
  ssh_keys ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2qM48j/fVhoJlXnQ7i4XNj8wE8zpRJMJMT1PllPqCGW/IMdnQfoIw43fHtOCSyoEGmJ9IWtbxQK2/+XkcycIILw1EAfBYw5/DKi9EwvlFmyIe3sj2R9TdJ31Dv7wTlEOkYfY8dSUjSJc8aai2KmmWuvHudL4qhT7yxN4j2pFeoo6ACtnwxgYcrtG2jBeZtSqdW7mWBXZh0SJglo1lyMtZ2gmkqj8tutynZix6pxdAoP8gcQEWOjINxNJe+T+zbxsjkFZg0SrYK/ismO/ZjJvPYmbDMudxQhRyPx+KB4K1yEwn5xgzcnO6su8alXOIxCER7Bh7Bl51td9RaCx3dXdp huangrichard@Huangs-MacBook-Air.local"]
  supports manage_home: true
end

god_monitor "leaderboard-rails" do
  config "leaderboard-rails.god.erb"
end
