# frozen_string_literal: true
json.poll_option do
  json.partial! "_poll_option", locals: { poll_option: @poll_option }
end
