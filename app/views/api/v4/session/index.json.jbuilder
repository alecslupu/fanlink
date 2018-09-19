json.person do
  json.partial! "api/v4/people/person_private", locals: { person: @person, relationships: @person.relationships }
end
