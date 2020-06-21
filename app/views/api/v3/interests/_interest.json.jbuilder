# frozen_string_literal: true

json.id interest.id
json.title interest.title
json.order interest.order
if interest.children.present?
  json.sub_interests  interest.children, partial: "api/v3/interests/interest", as: :interest
else
  json.sub_interests nil
end
