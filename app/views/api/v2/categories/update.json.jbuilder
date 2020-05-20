# frozen_string_literal: true
json.category do
  json.partial! "category", locals: { category: @category }
end
