class UsersController < ApplicationController
  def show
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @user = User.find(params[:id])
    @score = @leaderboard.scores.where(user_id: @user.id).first
    render json: {score: @score.value, rank: @score.rank}
  end
end
