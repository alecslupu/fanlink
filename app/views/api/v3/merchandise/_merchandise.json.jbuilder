# frozen_string_literal: true
json.id merchandise.id.to_s
json.name merchandise.name(@lang)
json.description merchandise.description(@lang)
json.price merchandise.price
json.purchase_url merchandise.purchase_url
json.picture_url merchandise.picture_url
json.available merchandise.available
json.priority merchandise.priority
