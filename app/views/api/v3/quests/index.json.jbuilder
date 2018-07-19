if current_user.some_admin? && current_user.app == "portal"
  json.quests do
    json.array!(@quests) do |quest|
      json.partial! "quest", locals: { quest: quest, lang: @lang }
    end
  end
elsif current_user.tester
    json.quests do
        json.array!(@quests) do |quest|
          next if %w[ deleted disabled].includes?(quest.status.to_s)
          next if quest.starts_at > DateTime.now
          next if quest.ends_at && quest.ends_at < DateTime.now
          json.partial! "quest", locals: { quest: quest, lang: @lang }
        end
else
    json.quests do
        json.array!(@quests) do |quest|
        next if %w[ deleted disabled enabled ].includes?(quest.status.to_s)
        next if quest.starts_at > DateTime.now
        next if quest.ends_at && quest.ends_at < DateTime.now
        json.partial! "quest", locals: { quest: quest, lang: @lang }
        end
    end
end
