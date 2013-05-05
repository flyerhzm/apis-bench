class AddGameIdToLeaderboards < ActiveRecord::Migration
  def change
    add_column :leaderboards, :game_id, :integer, index: true
  end
end
