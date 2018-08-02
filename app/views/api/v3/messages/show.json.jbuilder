json.message do
  json.cache! ["v3", @message], expires_in: 10.minutes do
    json.partial! "message", locals: { message: @message }
  end
end
