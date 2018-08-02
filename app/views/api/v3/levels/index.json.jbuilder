json.levels do
  json.array!(@levels) do |level|
    json.cache! ["v3", level, @lang] do
      json.partial! "level", locals: { level: level, lang: @lang }
    end
  end
end
