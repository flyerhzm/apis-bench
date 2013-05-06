require 'faker'

User.delete_all
Score.delete_all
Leaderboard.delete_all
Game.delete_all

10.times do
  game = Game.create name: Faker::Name.name
  100.times do
    leaderboard = game.leaderboards.create name: Faker::Name.name
    1000.times do
      user = User.create name: Faker::Name.name, email: Faker::Internet.email
      leaderboard.scores.create value: rand(1_000_000_000), user: user
    end
  end
end
