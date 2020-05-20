# frozen_string_literal: true
json.rewards do
    json.array!(@person_rewards) do |reward|
      json.reward do
        json.partial! "person_reward", locals: { reward: reward, lang: @lang }
        json.person reward.person
      end
    end
  end
