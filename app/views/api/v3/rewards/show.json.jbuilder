json.reward do
  json.cache! ["v3", @reward, @lang], expires_in: 10.minutes do
    json.partial! "reward", locals: { reward: @reward, lang: @lang }
  end
end
