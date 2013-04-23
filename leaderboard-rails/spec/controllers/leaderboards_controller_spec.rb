require 'spec_helper'

describe LeaderboardsController do
  let(:game) { FactoryGirl.create(:game) }
  context "GET #index" do
    before do
      @leaderboard1 = FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard 1")
      FactoryGirl.create(:leaderboard, game_id: 0)
      @leaderboard2 = FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard 2")
    end

    it "gets first 2 leaderboards" do
      get :index, game_id: game.id, format: 'json'
      expect(MultiJson.decode(response.body)).to eq [
        {"id" => @leaderboard1.id, "name" => "Leaderboard 1"},
        {"id" => @leaderboard2.id, "name" => "Leaderboard 2"}
      ]
    end

    it "gets nothing for page 2" do
      get :index, game_id: game.id, page: 2, format: 'json'
      expect(MultiJson.decode(response.body)).to eq []
    end
  end

  context "GET #show" do
    let(:leaderboard) { FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard") }
    before { get :show, game_id: game.id, id: leaderboard.id, format: 'json' }

    it "gets leaderboard" do
      expect(MultiJson.decode(response.body)).to eq({"id" => leaderboard.id, "name" => "Leaderboard"})
    end
  end
end
