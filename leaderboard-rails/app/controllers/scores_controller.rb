class ScoresController < ApplicationController
  before_filter :load_leaderboard

  def index
    page = params[:page] ? params[:page].to_i : 1
    @scores = @leaderboard.scores.sort_by_value.page(page)
  end

private
  def load_leaderboard
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
  end
end
