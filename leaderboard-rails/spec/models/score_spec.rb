require 'spec_helper'

describe Score do
  it { should belong_to :leaderboard }
  it { should belong_to :user }
end
