json.product do
  json.partial! "product", locals: { product: @product }
end
