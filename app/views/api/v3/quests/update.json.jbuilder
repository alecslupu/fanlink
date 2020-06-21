# frozen_string_literal: true

json.quest do
  json.cache! ["v3", @quest] do
    json.partial! "quest", locals: { quest: @quest, lang: nil }
  end
  quest_completed = current_user.quest_completed.find { |x| x.quest_id == @quest.id }
  json.completed ((quest_completed) ? true : false)
  json.completed_at ((quest_completed) ? quest_completed.created_at : nil)
  if @quest.steps.count > 0
    json.steps do
      json.array!(@quest.steps) do |step|
        json.partial! "api/v3/steps/step", locals: { step: step }
      end
    end
  else
    json.steps nil
  end

  @quest.rewards.each do |assigned|
    if assigned.badge
      json.assigned_badge assigned.badge
      json.badge do
        json.partial! "api/v3/badges/badge", locals: { badge: assigned.badge }
      end
    else
      json.badge nil
    end
  end
end
