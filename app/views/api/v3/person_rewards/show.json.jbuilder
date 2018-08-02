json.reward do
  json.cache! ["v3", @person_reward], expires_in: 10.minutes do
    json.person @person_reward.person
    json.partial! "person_reward", locals: { reward: @person_reward, lang: nil }
  end
end
