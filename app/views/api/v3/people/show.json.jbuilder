json.person do
    json.cache! ['v3', @person], expires_in: 10.minutes do
        json.partial! "person", locals: { person: @person }
    end
end
