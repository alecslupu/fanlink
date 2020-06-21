# frozen_string_literal: true

json.category do
  json.cache! ["v3", @category] do
    json.partial! "category", locals: { category: @category }
  end
end
