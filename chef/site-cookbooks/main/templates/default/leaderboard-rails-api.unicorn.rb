shared_path = "/home/deploy/sites/apis-bench/shared"

worker_processes 1
working_directory "/home/deploy/sites/apis-bench/current/leaderboard-rails-api"
listen 4000, :tcp_nopush => true
timeout 30
pid shared_path + "/pids/leaderboard-rails-api.unicorn.pid"
stderr_path shared_path + "/log/leaderboard-rails-api.unicorn.stderr.log"
stdout_path shared_path + "/log/leaderboard-rails-api.unicorn.stdout.log"
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true
#check_client_connection false

before_fork do |server, worker|
  old_pid = shared_path + "/pids/leaderboard-rails-api.unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
