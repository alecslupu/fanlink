json.cache! ['V3', @person] do
    json.person do
        json.partial! "api/v3/people/person_private", locals: { person: @person, relationships: @person.relationships }
    end
end
