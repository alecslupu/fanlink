json.person do
  json.partial! "api/v2/people/person_private", locals: { person: @person, relationships: @person.relationships }
end
