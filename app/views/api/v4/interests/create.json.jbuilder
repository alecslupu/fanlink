json.badge do
    json.partial! "api/v4/interests/interest", locals: { interest: @interest, lang: nil }
end
