class Leaderboard < ActiveRecord::Base
  PER_PAGE = 10
  belongs_to :game
  has_many :scores
  attr_accessible :name

  def self.page(page)
    offset = (page - 1) * PER_PAGE
    offset(offset).limit(PER_PAGE)
  end
end
