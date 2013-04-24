require 'spec_helper'

describe UsersController do
  let(:leaderboard) { FactoryGirl.create(:leaderboard) }
  let(:user) { FactoryGirl.create(:user) }

  context "GET #show" do
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
