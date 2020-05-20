# frozen_string_literal: true
json.message do
  json.partial! "message", locals: { message: @message }
end
