# apis-bench

## How to

add `/etc/hosts`

```
192.168.0.167 apis-bench
192.168.0.167 leaderboard-rails
192.168.0.167 leaderboard-rails-api
192.168.0.167 leaderboard-sinatra
192.168.0.167 leaderboard-sinatra-synchrony
192.168.0.167 leaderboard-grape
192.168.0.167 leaderboard-grape-goliath
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
cap deploy
```

seed data, it takes a very very very long time :-)

```
cap deploy:seed
```

then it's ready.
