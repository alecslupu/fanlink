# frozen_string_literal: true

json.relationship do
  json.partial! "relationship", locals: { relationship: @relationship }
end
