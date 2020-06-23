# frozen_string_literal: true

json.products @products do |product|
  json.name product.name
  json.internal_name product.internal_name
  json.id product.id
end
