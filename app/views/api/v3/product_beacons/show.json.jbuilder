json.beacon do
  json.cache! ["v3", @product_beacon], expires_in: 10.minutes do
    json.partial! "beacon", locals: { beacon: @product_beacon }
  end
end
