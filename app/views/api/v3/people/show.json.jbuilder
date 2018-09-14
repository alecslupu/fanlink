json.person do
  json.partial! "person", locals: { person: @person }
end
