# apis-bench

## How to

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

start god in server

```
rvmsudo god -c /tmp/god.conf
```

deploy code

```
NEW_RELIC_LICENSE_KEY=xxx cap deploy
```

seed data, it takes a very very very long time :-)

```
cap deploy:seed
```

then it's ready.

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
