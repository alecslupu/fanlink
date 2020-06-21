# frozen_string_literal: true

json.categories do
  json.array!(@categories) do |category|
    json.partial! "category", locals: { category: category }
  end
end
