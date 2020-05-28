# frozen_string_literal: true
json.rewards do
  json.array!(@rewards) do |reward|
    json.id reward.id
    json.name reward.name
    json.internal_name reward.internal_name
  end
end
