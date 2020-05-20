# frozen_string_literal: true
json.product do
  json.partial! "product", locals: { product: @product }
end
