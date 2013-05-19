class UsersController < ApplicationController
  respond_to :json
  before_filter :load_leaderboard

  def index
    page = params[:page] ? params[:page].to_i : 1
    @scores = @leaderboard.scores.sort_by_value.page(page)
    respond_with @scores
  end

  def show
    @user = User.find(params[:id])
    @score = @leaderboard.scores.where(user_id: @user.id).first
    render json: {score: @score.value, rank: @score.rank}
  end

private
  def load_leaderboard
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
  end
end
