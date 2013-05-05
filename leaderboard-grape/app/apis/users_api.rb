class UsersAPI < Grape::API
  use Rack::Config do |env|
    env['api.tilt.root'] = 'app/views'
  end
  format :json
  formatter :json, Grape::Formatter::Jbuilder

  resources 'leaderboards' do
    segment ':leaderboard_id' do
      resources 'users' do
        get '/', jbuilder: 'users/index.json' do
          @leaderboard = Leaderboard.find(params[:leaderboard_id])
          page = params[:page] ? params[:page].to_i : 1
          @scores = @leaderboard.scores.sort_by_value.page(page)
        end

        get ':id', jbuilder: 'users/show.json' do
          @leaderboard = Leaderboard.find(params[:leaderboard_id])
          @user = User.find(params[:id])
          @score = @leaderboard.scores.where(user_id: @user.id).first
        end
      end
    end
  end
end
