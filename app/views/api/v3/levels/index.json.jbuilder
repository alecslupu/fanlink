# frozen_string_literal: true

json.levels do
  json.array!(@levels) do |level|
    json.cache! ['v3', @lang, level] do
      json.partial! 'level', locals: { level: level, lang: @lang }
    end
  end
end
