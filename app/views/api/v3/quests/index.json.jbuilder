# frozen_string_literal: true

if current_user.some_admin? && @req_source == 'web'
  json.quests do
    json.array!(@quests) do |quest|
      json.partial! 'quest', locals: { quest: quest, lang: @lang }
    end
  end
elsif current_user.tester
  json.quests do
    json.array!(@quests) do |quest|
      next if %w[deleted disabled].include?(quest.status.to_s)
      next if quest.starts_at > DateTime.now
      next if quest.ends_at && quest.ends_at < DateTime.now

      json.partial! 'quest', locals: { quest: quest, lang: @lang }
    end
  end
else
  json.quests do
    json.array!(@quests) do |quest|
      next if %w[deleted disabled enabled].include?(quest.status.to_s)
      next if quest.starts_at > DateTime.now
      next if quest.ends_at && quest.ends_at < DateTime.now

      json.partial! 'quest', locals: { quest: quest, lang: @lang }
    end
  end
end
