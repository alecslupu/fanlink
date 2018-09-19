if defined?(@followers)
  json.followers @followers, partial: "api/v4/people/person", as: :person
else
  json.following @following, partial: "api/v4/people/person", as: :person
end
