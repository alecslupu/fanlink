json.type do
  json.partial! "type", locals: { atype: @activity_type, lang: nil }
end
