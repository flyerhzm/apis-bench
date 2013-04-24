json.array! @scores do |score|
  json.(score, :value)
  json.user do
    json.(score.user, :id, :name)
  end
end
