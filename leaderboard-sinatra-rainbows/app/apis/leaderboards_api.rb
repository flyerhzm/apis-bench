class LeaderboardsAPI < BaseAPI
  helpers Sinatra::JSON

  get '/games/:game_id/leaderboards.json' do
    @game = Game.find(params[:game_id])
    page = params[:page] ? params[:page].to_i : 1
    @leaderboards = @game.leaderboards.page(page)
    json @leaderboards
  end

  get '/games/:game_id/leaderboards/:id.json' do
    @game = Game.find(params[:game_id])
    @leaderboard = @game.leaderboards.find(params[:id])
    json @leaderboard
  end

  post '/games/:game_id/leaderboards.json' do
    @game = Game.find(params[:game_id])
    @leaderboard = @game.leaderboards.create(name: params[:name])
    json @leaderboard
  end

  put '/games/:game_id/leaderboards/:id.json' do
    @game = Game.find(params[:game_id])
    @leaderboard = @game.leaderboards.find(params[:id])
    @leaderboard.update_attributes(name: params[:name])
    json @leaderboard
  end
end
