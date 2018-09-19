json.relationship do
  json.partial! "relationship", locals: { relationship: @relationship }
end
