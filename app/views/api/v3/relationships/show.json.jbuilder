json.relationship do
    json.cache! ['v3', @relationship], expires_in: 10.minutes do
        json.partial! "relationship", locals: { relationship: @relationship }
    end
end
