json.product do
    json.cache! ['v3', @product], expires_in: 10.minutes do
        json.partial! "product", locals: { product: @product }
    end
end
