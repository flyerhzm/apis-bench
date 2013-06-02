# apis-bench

## Setup

add `/etc/hosts`

```
192.168.0.167 apis-bench
```

192.168.0.167 is ip address of your virtual machine.

installation, assume you already have chef installed on apis-bench
server and has a deploy account with sudo privilege

```
cd chef
bundle
knife solo cook deploy@apis-bench
```

start god

```
cap deploy:start_god
```

deploy code

```
cap deploy
```

seed data, it takes a very very very long time :-)

```
cap deploy:seed
```

then it's ready, make sure the database is warmed up before you start
benchmark.

```
leaderboard-rails at port 3000
leaderboard-rails-api at port 4000
leaderboard-sinatra.unicorn at port 5000
leaderboard-grape.unicorn at port 6000
leaderboard-sinatra.rainbows at port 7000
leaderboard-grape.rainbows at port 8000
leaderboard-sinatra-synchrony at port 10000
leaderboard-grape-goliath at port 11000
```

## NewRelic

if you want to measure the performance on newrelic, add you newrelic
license key besides NEW_RELIC_APP_NAME in the following god files, like

```
NEW_RELIC_APP_NAME=leaderboard-rails NEW_RELIC_LICENSE_KEY=xxx
```

```
chef/site-cookbooks/main/templates/default/leaderboard-rails.god
chef/site-cookbooks/main/templates/default/leaderboard-rails-api.god
chef/site-cookbooks/main/templates/default/leaderboard-sinatra.unicorn.god
chef/site-cookbooks/main/templates/default/leaderboard-grape.unicorn.god
chef/site-cookbooks/main/templates/default/leaderboard-sinatra.rainbows.god
chef/site-cookbooks/main/templates/default/leaderboard-grape.rainbows.god
chef/site-cookbooks/main/templates/default/leaderboard-sinatra-synchrony.god
chef/site-cookbooks/main/templates/default/leaderboard-grape-goliath.god
```

## Known Issues

1. failed to add newrelic to leaderboard-sinatra-synchrony
2. failed to add fiber_pool to leaderboard-grape-goliath

I appreciate it if you can help to solve the issue and open a pull
request to me, thanks.
