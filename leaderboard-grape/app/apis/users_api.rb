class UsersAPI < Grape::API
  format :json

  resources 'leaderboards' do
    segment ':leaderboard_id' do
      resources 'users' do
        get '/' do
          @leaderboard = Leaderboard.find(params[:leaderboard_id])
          page = params[:page] ? params[:page].to_i : 1
          @scores = @leaderboard.scores.sort_by_value.page(page)
        end

        get ':id' do
          @leaderboard = Leaderboard.find(params[:leaderboard_id])
          @user = User.find(params[:id])
          @score = @leaderboard.scores.where(user_id: @user.id).first
          {score: @score.value, rank: @score.rank}
        end
      end
    end
  end
end
