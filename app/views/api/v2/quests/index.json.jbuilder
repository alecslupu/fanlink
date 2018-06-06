if current_user.some_admin? && current_user.app == "portal"
  json.quests do
    json.array!(@quests) do |quest|
      json.partial! "quest", locals: { quest: quest, lang: @lang }
    end
  end
else
  json.quests do
    json.array!(@quests) do |quest|
      next if quest.status.to_s != "active"
      next if quest.starts_at > DateTime.now
      next if quest.ends_at < DateTime.now
      json.partial! "quest", locals: { quest: quest, lang: @lang }
    end
  end
end