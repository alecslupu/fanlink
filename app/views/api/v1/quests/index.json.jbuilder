json.quests do
    json.array!(@quests) do |quest|
      json.partial! "quest", locals: { quest: quest, lang: @lang }
    end
  end