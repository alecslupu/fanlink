json.activities do
    json.array!(@step.quest_activities) do |activity|
        json.cache! ['v3', activity] do
            json.partial! "activity", locals: { activity: activity }
        end
    end
end
