# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :score do
    value 1
    user nil
    leaderboard nil
  end
end
