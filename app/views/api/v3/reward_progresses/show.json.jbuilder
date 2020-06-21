# frozen_string_literal: true

json.progress do
  json.partial! "reward_progress", locals: { progress: @progress }
end
