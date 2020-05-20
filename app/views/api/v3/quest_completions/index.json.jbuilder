# frozen_string_literal: true
json.completions do
    json.array!(@completions) do |completion|
      json.partial! "completion", locals: { completion: completion }
    end
  end
