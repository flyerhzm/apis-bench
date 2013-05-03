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

  context "POST #create" do
    before { post :create, game_id: game.id, name: "Leaderboard", format: 'json' }

    it "get created leaderboard" do
      expect(MultiJson.decode(response.body)).to eq({"id" => Leaderboard.last.id, "name" => "Leaderboard"})
    end
  end

  context "PUT #update" do
    let(:leaderboard) { FactoryGirl.create(:leaderboard, game: game, name: "Leaderboard") }
    before { put :update, game_id: game.id, id: leaderboard.id, name: "New Leaderboard", format: 'json' }

    it "get updates leaderboard" do
      expect(MultiJson.decode(response.body)).to eq({"id" => leaderboard.id, "name" => "New Leaderboard"})
    end
  end
end
