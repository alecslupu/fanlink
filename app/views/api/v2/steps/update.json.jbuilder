# frozen_string_literal: true
json.step do
  json.partial! "step", locals: { step: @step, lang: nil }
end
