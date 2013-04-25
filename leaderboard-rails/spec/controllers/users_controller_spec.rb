require 'spec_helper'

describe UsersController do
  let(:leaderboard) { FactoryGirl.create(:leaderboard) }

  context "GET #index" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }

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

  context "GET #show" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      FactoryGirl.create(:score, leaderboard: leaderboard, value: 1)
      FactoryGirl.create(:score, leaderboard: leaderboard, user: user, value: 3)
      FactoryGirl.create(:score, leaderboard: leaderboard, value: 5)
      FactoryGirl.create(:score, leaderboard: leaderboard, value: 7)
      get :show, leaderboard_id: leaderboard.id, id: user.id
    end

    it "gets user's score and rank" do
      expect(MultiJson.decode(response.body)).to eq({"score" => 3, "rank" => 3})
    end
  end
end