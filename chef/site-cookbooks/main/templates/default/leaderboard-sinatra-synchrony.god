#!/usr/bin/ruby

sinatra_root = '/home/deploy/sites/apis-bench/current/leaderboard-sinatra-synchrony'
shared_root = '/home/deploy/sites/apis-bench/shared'

God.watch do |w|
  w.name = "leaderboard-sinatra-synchrony.thin"
  w.interval = 30.seconds # default

  w.start = "cd #{sinatra_root} && NEW_RELIC_APP_NAME=leaderboard-sinatra-synchrony RACK_ENV=production bundle exec thin start -e production -P #{shared_root}/pids/leaderboard-sinatra-synchrony.thin.pid -S /tmp/leaderboard-sinatra-synchrony.thin.sock -l #{shared_root}/log/leaderboard-sinatra-synchrony.thin.log -d"

  w.stop = "kill -QUIT `cat #{shared_root}/pids/leaderboard-sinatra-synchrony.thin.pid`"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "#{shared_root}/pids/leaderboard-sinatra-synchrony.thin.pid"

  w.uid = 'deploy'
  w.gid = 'deploy'

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 300.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end
  end

  # lifecycle
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
