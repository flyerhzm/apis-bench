shared_path = "/home/deploy/sites/apis-bench/shared"

worker_processes 1
working_directory "/home/deploy/sites/apis-bench/current/leaderboard-grape"
listen 7000, :tcp_nopush => true
timeout 30
pid shared_path + "/pids/leaderboard-grape.rainbows.pid"
stderr_path shared_path + "/log/leaderboard-grape.rainbows.stderr.log"
stdout_path shared_path + "/log/leaderboard-grape.rainbows.stdout.log"
preload_app true

Rainbows! do
  use :ThreadSpawn
  worker_connections 400
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end

    sleep 1
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end
