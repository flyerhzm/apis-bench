require 'faker'
require 'activerecord-import'

%w(users scores leaderboards games).each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
  ActiveRecord::Base.connection.execute("ALTER TABLE #{table} AUTO_INCREMENT=1")
end

GAME_COUNT = Rails.env.production? ? 10 : 1
LEADERBOARD_COUNT = Rails.env.production? ? 1000 : 10
SCORE_COUNT = Rails.env.production? ? 10_000 : 100

games = []
GAME_COUNT.times do
  games << Game.new(name: Faker::Name.name)
end
Game.import games

game_id = Game.order("id asc").first.id
GAME_COUNT.times do
  leaderboards = []
  (LEADERBOARD_COUNT / GAME_COUNT).times do
    leaderboards << Leaderboard.new(name: Faker::Name.name, game_id: rand(GAME_COUNT) + game_id)
  end
  Leaderboard.import leaderboards
end

leaderboard_id = Leaderboard.order("id asc").first.id
LEADERBOARD_COUNT.times do |i|
  users = []
  SCORE_COUNT.times do
    users << User.new(name: Faker::Name.name, email: Faker::Internet.email)
  end
  User.import users

  user_id = User.order("id asc").first.id
  scores = []
  SCORE_COUNT.times do
    scores << Score.new(
      value: rand(1_000_000_000),
      leaderboard_id: rand(LEADERBOARD_COUNT) + leaderboard_id,
      user_id: SCORE_COUNT * i + rand(SCORE_COUNT) + user_id
    )
  end
  Score.import scores
end
