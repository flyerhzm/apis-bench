class LeaderboardsApp < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), "../views")

  get '/games/:game_id/leaderboards.json' do
    @game = Game.find(params[:game_id])
    page = params[:page] ? params[:page].to_i : 1
    @leaderboards = @game.leaderboards.page(page)
    jbuilder 'leaderboards/index.json'.to_sym
  end

  get '/games/:game_id/leaderboards/:id.json' do
    @game = Game.find(params[:game_id])
    @leaderboard = @game.leaderboards.find(params[:id])
    jbuilder 'leaderboards/show.json'.to_sym
  end

  post '/games/:game_id/leaderboards.json' do
    @game = Game.find(params[:game_id])
    @leaderboard = @game.leaderboards.create(name: params[:name])
    jbuilder 'leaderboards/show.json'.to_sym
  end

  put '/games/:game_id/leaderboards/:id.json' do
    @game = Game.find(params[:game_id])
    @leaderboard = @game.leaderboards.find(params[:id])
    @leaderboard.update_attributes(name: params[:name])
    jbuilder 'leaderboards/show.json'.to_sym
  end
end
