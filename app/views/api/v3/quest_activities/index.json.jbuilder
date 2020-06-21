# frozen_string_literal: true

json.activities do
  json.array!(@step.quest_activities) do |activity|
    json.partial! "activity", locals: { activity: activity }
  end
end
