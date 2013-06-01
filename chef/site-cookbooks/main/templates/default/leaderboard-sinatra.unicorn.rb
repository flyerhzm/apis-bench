shared_path = "/home/deploy/sites/apis-bench/shared"

worker_processes 1
working_directory "/home/deploy/sites/apis-bench/current/leaderboard-sinatra"
listen 5000, :tcp_nopush => true
timeout 30
pid shared_path + "/pids/leaderboard-sinatra.unicorn.pid"
stderr_path shared_path + "/log/leaderboard-sinatra.unicorn.stderr.log"
stdout_path shared_path + "/log/leaderboard-sinatra.unicorn.stdout.log"
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true
#check_client_connection false

before_fork do |server, worker|
  old_pid = shared_path + "/pids/leaderboard-sinatra.unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    env = ENV['RACK_ENV'] || "development"
    config = YAML::load(File.open('config/database.yml'))[env]
    ActiveRecord::Base.establish_connection(config)
  end
end
