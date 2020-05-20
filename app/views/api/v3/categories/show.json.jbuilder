# frozen_string_literal: true
json.category do
  json.cache! ["v3", @category], expires_in: 10.minutes do
    json.partial! "category", locals: { category: @category }
  end
end
