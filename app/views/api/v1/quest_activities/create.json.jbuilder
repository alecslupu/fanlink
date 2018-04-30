json.quest do
    json.partial! "activity", locals: { activity: @quest_activity, lang: nil }
end
  