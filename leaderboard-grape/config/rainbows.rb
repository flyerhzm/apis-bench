worker_processes 1
Rainbows! do
  use :ThreadSpawn
  worker_connections 200
end
