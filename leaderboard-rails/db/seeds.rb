require 'faker'

User.delete_all
Score.delete_all
Leaderboard.delete_all
Game.delete_all

GAME_COUNT = Rails.env.production? ? 10 : 1
LEADERBOARD_COUNT = Rails.env.production? ? 100 : 10
SCORE_COUNT = Rails.env.production? ? 100_000 : 100

GAME_COUNT.times do
  game = Game.create name: Faker::Name.name
  LEADERBOARD_COUNT.times do
    leaderboard = game.leaderboards.create name: Faker::Name.name
    SCORE_COUNT.times do
      user = User.create name: Faker::Name.name, email: Faker::Internet.email
      leaderboard.scores.create value: rand(1_000_000_000), user: user
    end
  end
end
