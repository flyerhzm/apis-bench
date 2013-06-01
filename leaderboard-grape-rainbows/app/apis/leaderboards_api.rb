class LeaderboardsAPI < Grape::API
  format :json

  resources 'games' do
    segment ':game_id' do
      resources 'leaderboards' do
        get '/' do
          @game = Game.find(params[:game_id])
          page = params[:page] ? params[:page].to_i : 1
          @leaderboards = @game.leaderboards.page(page)
        end

        get ':id' do
          @game = Game.find(params[:game_id])
          @leaderboard = @game.leaderboards.find(params[:id])
        end

        post '/' do
          @game = Game.find(params[:game_id])
          @leaderboard = @game.leaderboards.create(name: params[:name])
        end

        put ':id' do
          @game = Game.find(params[:game_id])
          @leaderboard = @game.leaderboards.find(params[:id])
          @leaderboard.update_attributes(name: params[:name])
          @leaderboard
        end
      end
    end
  end
end
