json.merchandise do
  json.cache! ["v3", @merchandise, @lang] do
    json.partial! "merchandise", locals: { merchandise: @merchandise, lang: @lang }
  end
end
