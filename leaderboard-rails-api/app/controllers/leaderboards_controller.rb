class LeaderboardsController < ApplicationController
  before_filter :load_game

  def index
    page = params[:page] ? params[:page].to_i : 1
    @leaderboards = @game.leaderboards.page(page)
  end

  def show
    @leaderboard = @game.leaderboards.find(params[:id])
  end

  def create
    @leaderboard = @game.leaderboards.create(name: params[:name])
    render action: :show
  end

  def update
    @leaderboard = @game.leaderboards.find(params[:id])
    @leaderboard.update_attributes(name: params[:name])
    render action: :show
  end

private
  def load_game
    @game = Game.find(params[:game_id])
  end
end
