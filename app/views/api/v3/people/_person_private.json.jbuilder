json.partial! "api/v3/people/person", locals: { person: person }
json.cache! ["v3", "private", person] do
  json.email person.email
  json.set! :product do
    json.internal_name person.product.internal_name
    json.id person.product.id
    json.name person.product.name
  end
end
if person.level_progresses.empty?
  json.level_progress nil
else
  json.level_progress person.level_progresses, partial: "api/v3/level_progresses/level_progress", as: :level
end

if person.person_rewards.empty?
  json.rewards nil
else
  json.rewards person.person_rewards, partial: "api/v3/person_rewards/person_reward", as: :reward
end
if person.blocked_people.empty?
  json.blocked_people nil
else
  json.blocked_people do
    json.array! person.blocked_people do |bp|
      json.id bp.id
      json.username bp.username
    end
  end
end
json.permissions person.summarize_permissions

if person.pinned_to.present?
  json.pin_messages_to do
    json.array!(person.pin_messages) do |pin|
      json.id pin.id
      json.room_id pin.room.id
      json.room_name pin.room.name
    end
  end
else
  json.pin_messages_to nil
end
