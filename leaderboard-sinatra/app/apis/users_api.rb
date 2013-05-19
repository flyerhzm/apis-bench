class LeaderboardsAPI < BaseAPI
  get '/leaderboards/:leaderboard_id/users.json' do
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    page = params[:page] ? params[:page].to_i : 1
    @scores = @leaderboard.scores.sort_by_value.page(page)
    halt MultiJson.encode(@scores)
  end

  get '/leaderboards/:leaderboard_id/users/:id.json' do
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @user = User.find(params[:id])
    @score = @leaderboard.scores.where(user_id: @user.id).first
    halt MultiJson.encode(score: @score.value, rank: @score.rank)
  end
end
