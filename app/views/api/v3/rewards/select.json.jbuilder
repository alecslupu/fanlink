json.rewards do
  json.array!(@rewards) do |reward|
    json.id reward.id
    json.name reward.name(@lang)
    json.internal_name reward.internal_name
  end
end
