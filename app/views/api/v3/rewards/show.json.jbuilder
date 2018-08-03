json.reward do
  json.partial! "reward", locals: { reward: @reward, lang: @lang }
end
