# frozen_string_literal: true

json.reward do
  json.person @person_reward.person
  json.partial! "person_reward", locals: { reward: @person_reward, lang: nil }
end
