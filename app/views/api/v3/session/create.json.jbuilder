json.person do
  json.partial! "api/v3/people/person_private", locals: { person: @person }
end
