json.person do
  json.partial! "person_slow", locals: { person: @person }
end
