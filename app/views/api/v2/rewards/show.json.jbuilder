# frozen_string_literal: true

json.reward do
  json.partial! 'reward', locals: { reward: @reward, lang: @lang }
end
