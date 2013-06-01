class AddGameIdIndexToLeaderboards < ActiveRecord::Migration
  def change
    add_index :leaderboards, :game_id
  end
end
