class LeaderboardsController < ApplicationController
  respond_to :json
  before_filter :load_game

  def index
    page = params[:page] ? params[:page].to_i : 1
    @leaderboards = @game.leaderboards.page(page)
    respond_with @leaderboards
  end

  def show
    @leaderboard = @game.leaderboards.find(params[:id])
    respond_with @leaderboard
  end

  def create
    @leaderboard = @game.leaderboards.create(name: params[:name])
    respond_with @leaderboard, location: game_leaderboard_url(@game, @leaderboard)
  end

  def update
    @leaderboard = @game.leaderboards.find(params[:id])
    @leaderboard.update_attributes(name: params[:name])
    respond_with @leaderboard
  end

private
  def load_game
    @game = Game.find(params[:game_id])
  end
end
