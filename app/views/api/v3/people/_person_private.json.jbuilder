json.partial! "api/v3/people/person", locals: { person: person }
json.email person.email
json.set! :product do
    json.internal_name person.product.internal_name
    json.id person.product.id
    json.name person.product.name
end
if  person.level_progresses.empty?
    json.level_progress nil
else
    json.level_progress person.level_progresses, partial: "api/v2/level_progresses/level_progress", as: :level
end

if  person.person_rewards.empty?
    json.rewards nil
else
    json.rewards person.person_rewards, partial: "api/v2/person_rewards/person_reward", as: :reward
end
