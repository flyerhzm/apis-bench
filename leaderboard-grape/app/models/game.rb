class Game < ActiveRecord::Base
  has_many :leaderboards
  attr_accessible :name
end
