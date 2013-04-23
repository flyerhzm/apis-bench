json.array! @leaderboards do |leaderboard|
  json.(leaderboard, :id, :name)
end
