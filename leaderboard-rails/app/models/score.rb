class Score < ActiveRecord::Base
  PER_PAGE = 10
  belongs_to :user
  belongs_to :leaderboard
  attr_accessible :value

  scope :sort_by_value, -> { order("value desc") }

  def self.page(page)
    offset = (page - 1) * PER_PAGE
    offset(offset).limit(PER_PAGE)
  end

  def rank
    Score.where("value > ?", value).count + 1
  end
end
