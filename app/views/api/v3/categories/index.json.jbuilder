# frozen_string_literal: true
json.categories do
  json.array!(@categories) do |category|
    json.cache! ["v3", category] do
      json.partial! "category", locals: { category: category }
    end
  end
end
