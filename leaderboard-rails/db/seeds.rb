require 'faker'

Game.delete_all

10.times do |i|
  Game.create name: Faker::Name.name
end
