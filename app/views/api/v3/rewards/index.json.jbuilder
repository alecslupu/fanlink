# frozen_string_literal: true

json.rewards do
  json.array!(@rewards) do |reward|
    json.partial! "reward", locals: { reward: reward, lang: @lang }
  end
end
