# frozen_string_literal: true

json.beacon do
  json.partial! 'beacon', locals: { beacon: @product_beacon }
end
