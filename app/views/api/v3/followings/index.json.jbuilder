if defined?(@followers)
  json.followers @followers, partial: "api/v1/people/person", as: :person
else
  json.following @following, partial: "api/v1/people/person", as: :person
end
