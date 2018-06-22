json.rewards do
    json.array!(@person_rewards) do |reward|
      json.partial! "person_reward", locals: { reward: reward, lang: @lang }
    end
  end
