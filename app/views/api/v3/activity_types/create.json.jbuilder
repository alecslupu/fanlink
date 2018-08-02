json.type do
  json.cache! ["v3",  @activity_type] do
    json.partial! "type", locals: { atype: @activity_type, lang: nil }
  end
end
