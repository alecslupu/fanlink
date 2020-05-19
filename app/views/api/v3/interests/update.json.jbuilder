# frozen_string_literal: true
json.badge do
  json.partial! "api/v3/interests/interest", locals: { interest: @interest, lang: nil }
end
