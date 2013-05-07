class LeaderboardsAPI < Grape::API
  use Rack::Config do |env|
    env['api.tilt.root'] = 'app/views'
  end
  format :json
  formatter :json, Grape::Formatter::Jbuilder

  resources 'games' do
    segment ':game_id' do
      resources 'leaderboards' do
        get '/', jbuilder: 'leaderboards/index.json' do
          @game = Game.find(params[:game_id])
          page = params[:page] ? params[:page].to_i : 1
          @leaderboards = @game.leaderboards.page(page)
        end

        get ':id', jbuilder: 'leaderboards/show.json' do
          @game = Game.find(params[:game_id])
          @leaderboard = @game.leaderboards.find(params[:id])
        end

        post '/', jbuilder: 'leaderboards/show.json' do
          @game = Game.find(params[:game_id])
          @leaderboard = @game.leaderboards.create(name: params[:name])
        end

        put ':id', jbuilder: 'leaderboards/show.json' do
          @game = Game.find(params[:game_id])
          @leaderboard = @game.leaderboards.find(params[:id])
          @leaderboard.update_attributes(name: params[:name])
        end
      end
    end
  end
end
