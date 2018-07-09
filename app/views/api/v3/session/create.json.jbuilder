json.cache! ['V3', @person] do
    json.person @person, partial: "api/v3/people/person_private", as: :person
end
