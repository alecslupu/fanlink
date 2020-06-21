# frozen_string_literal: true

json.partial! "api/v2/people/person", locals: { person: person }
json.email person.email
json.set! :product do
  json.internal_name person.product.internal_name
  json.id person.product.id
  json.name person.product.name
end
