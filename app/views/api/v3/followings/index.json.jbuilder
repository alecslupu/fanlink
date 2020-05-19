# frozen_string_literal: true
if defined?(@followers)
  json.followers @followers, partial: "api/v3/people/person", as: :person
else
  json.following @following, partial: "api/v3/people/person", as: :person
end
