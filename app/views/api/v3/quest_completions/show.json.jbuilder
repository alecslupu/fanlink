json.completion do
  json.cache! ["v3", @completion], expires_in: 10.minutes do
    json.partial! "completion", locals: { completion: @completion }
  end
end
