json.person do
    json.cache! ['v3', @person], expires_in: 10.minutes do
        json.partial! "api/v3/people/person_private", locals: { person: @person }
    end
end
