json.id interest.id
json.title interest.title
if interest.children.present?
  json.sub_interests  interest.children, partial: "api/v4/interests/interest", as: :interest
else
  json.sub_interests nil
end
