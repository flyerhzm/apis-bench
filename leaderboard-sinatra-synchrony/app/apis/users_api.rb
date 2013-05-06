class LeaderboardsAPI < BaseAPI
  get '/leaderboards/:leaderboard_id/users.json' do
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    page = params[:page] ? params[:page].to_i : 1
    @scores = @leaderboard.scores.sort_by_value.page(page)
    jbuilder 'users/index.json'.to_sym
  end

  get '/leaderboards/:leaderboard_id/users/:id.json' do
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @user = User.find(params[:id])
    @score = @leaderboard.scores.where(user_id: @user.id).first
    jbuilder 'users/show.json'.to_sym
  end
end
