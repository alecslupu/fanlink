json.reward do
    json.partial! "person_reward", locals: { reward: @person_reward, lang: nil }
end
