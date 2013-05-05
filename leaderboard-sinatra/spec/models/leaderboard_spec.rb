require 'spec_helper'

describe Leaderboard do
  it { should belong_to :game }
  it { should have_many :scores }

  context ".page" do
    before do
      Leaderboard.send(:remove_const, :PER_PAGE)
      Leaderboard.const_set(:PER_PAGE, 2)
      @leaderboard1 = FactoryGirl.create(:leaderboard)
      @leaderboard2 = FactoryGirl.create(:leaderboard)
      @leaderboard3 = FactoryGirl.create(:leaderboard)
    end

    after do
      Leaderboard.send(:remove_const, :PER_PAGE)
      Leaderboard.const_set(:PER_PAGE, 10)
    end

    it "gets first 2 leaderboards" do
      expect(Leaderboard.page(1)).to eq [@leaderboard1, @leaderboard2]
    end

    it "gets last leaderboard" do
      expect(Leaderboard.page(2)).to eq [@leaderboard3]
    end
  end
end
