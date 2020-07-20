# frozen_string_literal: true

json.id merchandise.id.to_s
json.name merchandise.name
json.description merchandise.description
json.price merchandise.price
json.purchase_url merchandise.purchase_url
json.picture_url AttachmentPresenter.new(merchandise.picture).url
json.available merchandise.available
json.priority merchandise.priority
