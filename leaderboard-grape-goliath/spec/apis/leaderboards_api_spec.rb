require 'spec_helper'

describe LeaderboardsAPI do
  include Rack::Test::Methods

  def app
    LeaderboardsAPI
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
      expect(last_response.body).to eq MultiJson.encode([@leaderboard1, @leaderboard2])
    end

    it "gets nothing for page 2" do
      get "/games/#{game.id}/leaderboards.json?page=2"
      expect(last_response.body).to eq MultiJson.encode([])
    end
  end

  context "GET #show" do
    let(:leaderboard) { FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard") }
    before { get "/games/#{game.id}/leaderboards/#{leaderboard.id}.json" }

    it "gets leaderboard" do
      expect(last_response.body).to eq MultiJson.encode(leaderboard)
    end
  end

  context "POST #create" do
    before { post "/games/#{game.id}/leaderboards.json", name: "Leaderboard" }

    it "get created leaderboard" do
      expect(last_response.body).to eq MultiJson.encode(Leaderboard.last)
    end
  end

  context "PUT #update" do
    let(:leaderboard) { FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard") }
    before { put "/games/#{game.id}/leaderboards/#{leaderboard.id}.json", name: "New Leaderboard" }

    it "get updates leaderboard" do
      expect(last_response.body).to eq MultiJson.encode(Leaderboard.last)
    end
  end
end
