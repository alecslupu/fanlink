json.message do
  json.partial! "message", locals: { message: @message }
end
