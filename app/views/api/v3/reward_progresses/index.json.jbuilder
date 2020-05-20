# frozen_string_literal: true
json.progresses do
  json.array!(@progresses) do |progress|
    json.partial! "reward_progress", locals: { progress: progress }
  end
end
