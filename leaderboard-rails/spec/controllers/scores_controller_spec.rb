require 'spec_helper'

describe ScoresController do
  let(:leaderboard) { FactoryGirl.create(:leaderboard) }
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }

  context "GET #index" do
    before do
      @score1 = FactoryGirl.create(:score, leaderboard: leaderboard, user: user1, value: 15)
      FactoryGirl.create(:score, leaderboard_id: 0)
      @score2 = FactoryGirl.create(:score, leaderboard: leaderboard, user: user2, value: 5)
      @score3 = FactoryGirl.create(:score, leaderboard: leaderboard, user: user3, value: 10)
    end

    it "gets scores sort by value" do
      get :index, leaderboard_id: leaderboard.id, format: 'json'
      expect(MultiJson.decode(response.body)).to eq [
        {"value" => 15, "user" => {"id" => user1.id, "name" => user1.name}},
        {"value" => 10, "user" => {"id" => user3.id, "name" => user3.name}},
        {"value" => 5, "user" => {"id" => user2.id, "name" => user2.name}}
      ]
    end

    it "gets nothing for page 2" do
      get :index, leaderboard_id: leaderboard.id, page: 2, format: 'json'
      expect(MultiJson.decode(response.body)).to eq []
    end
  end
end
