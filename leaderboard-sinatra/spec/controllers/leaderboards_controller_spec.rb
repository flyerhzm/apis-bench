require 'spec_helper'

describe LeaderboardsApp do
  include Rack::Test::Methods

  def app
    LeaderboardsApp
  end

  let(:game) { FactoryGirl.create(:game) }

  context "GET #index" do
    before do
      @leaderboard1 = FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard 1")
      FactoryGirl.create(:leaderboard, game_id: 0)
      @leaderboard2 = FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard 2")
    end

    it "gets first 2 leaderboards" do
      get "/games/#{game.id}/leaderboards.json"
      expect(MultiJson.decode(last_response.body)).to eq [
        {"id" => @leaderboard1.id, "name" => "Leaderboard 1"},
        {"id" => @leaderboard2.id, "name" => "Leaderboard 2"}
      ]
    end

    it "gets nothing for page 2" do
      get "/games/#{game.id}/leaderboards.json?page=2"
      expect(MultiJson.decode(last_response.body)).to eq []
    end
  end

  context "GET #show" do
    let(:leaderboard) { FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard") }
    before { get "/games/#{game.id}/leaderboards/#{leaderboard.id}.json" }

    it "gets leaderboard" do
      expect(MultiJson.decode(last_response.body)).to eq({"id" => leaderboard.id, "name" => "Leaderboard"})
    end
  end

  context "POST #create" do
    before { post "/games/#{game.id}/leaderboards.json", name: "Leaderboard" }

    it "get created leaderboard" do
      expect(MultiJson.decode(last_response.body)).to eq({"id" => Leaderboard.last.id, "name" => "Leaderboard"})
    end
  end

  context "PUT #update" do
    let(:leaderboard) { FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard") }
    before { put "/games/#{game.id}/leaderboards/#{leaderboard.id}.json", name: "New Leaderboard" }

    it "get updates leaderboard" do
      expect(MultiJson.decode(last_response.body)).to eq({"id" => leaderboard.id, "name" => "New Leaderboard"})
    end
  end
end
