require 'spec_helper'

describe UsersAPI do
  include Rack::Test::Methods

  def app
    UsersAPI
  end

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
      get "/leaderboards/#{leaderboard.id}/users.json"
      expect(last_response.body).to eq MultiJson.encode([@score1, @score3, @score2])
    end

    it "gets nothing for page 2" do
      get "/leaderboards/#{leaderboard.id}/users.json?page=2"
      expect(last_response.body).to eq MultiJson.encode([])
    end
  end

  context "GET #show" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      FactoryGirl.create(:score, leaderboard: leaderboard, value: 1)
      FactoryGirl.create(:score, leaderboard: leaderboard, user: user, value: 3)
      FactoryGirl.create(:score, leaderboard: leaderboard, value: 5)
      FactoryGirl.create(:score, leaderboard: leaderboard, value: 7)
      get "/leaderboards/#{leaderboard.id}/users/#{user.id}.json"
    end

    it "gets user's score and rank" do
      expect(last_response.body).to eq MultiJson.encode("score" => 3, "rank" => 3)
    end
  end
end
