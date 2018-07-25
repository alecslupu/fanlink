if current_user.some_admin? && current_user.app == "portal"
  json.quests do
    json.array!(@quests) do |quest|
        json.cache! ['v3', 'portal', quest] do
            json.partial! "quest", locals: { quest: quest, lang: @lang }
        end
        quest_completed = current_user.quest_completed.find {|x| x.quest_id == quest.id}
        json.completed ((quest_completed) ? true : false)
        json.completed_at ((quest_completed) ? quest_completed.created_at : nil)
        if quest.steps.count > 0
            json.steps do
                json.array!(quest.steps) do |step|
                    json.cache! ['v3', step] do
                        json.partial! 'api/v3/steps/step', locals: { step: step }
                    end
                end
            end
        else
            json.steps nil
        end

        quest.rewards.each do |assigned|
            if assigned.badge
                json.assigned_badge assigned.badge
                json.badge do
                    json.cache! ['v3', assigned.badge] do
                        json.partial! 'api/v3/badges/badge', locals: { badge: assigned.badge }
                    end
                end
            else
            json.badge nil
            end
        end
    end
  end
elsif current_user.tester
    json.quests do
        json.array!(@quests) do |quest|
            next if %w[ deleted disabled].include?(quest.status.to_s)
            next if quest.starts_at > DateTime.now
            next if quest.ends_at && quest.ends_at < DateTime.now
            json.cache! ['v3', quest, @lang] do
                json.partial! "quest", locals: { quest: quest, lang: @lang }
            end
            quest_completed = current_user.quest_completed.find {|x| x.quest_id == quest.id}
            json.completed ((quest_completed) ? true : false)
            json.completed_at ((quest_completed) ? quest_completed.created_at : nil)
            if quest.steps.count > 0
                json.steps do
                    json.array!(quest.steps) do |step|
                        json.cache! ['v3', step] do
                            json.partial! 'api/v3/steps/step', locals: { step: step }
                        end
                   end
                end
            else
                json.steps nil
            end

            quest.rewards.each do |assigned|
                if assigned.badge
                    json.assigned_badge assigned.badge
                    json.badge do
                        json.cache! ['v3', assigned.badge] do
                            json.partial! 'api/v3/badges/badge', locals: { badge: assigned.badge }
                        end
                    end
                else
                json.badge nil
                end
            end
        end
    end
else
    json.quests do
        json.array!(@quests) do |quest|
            next if %w[ deleted disabled enabled ].include?(quest.status.to_s)
            next if quest.starts_at > DateTime.now
            next if quest.ends_at && quest.ends_at < DateTime.now
            json.cache! ['v3', quest, @lang] do
                json.partial! "quest", locals: { quest: quest, lang: @lang }
            end
            quest_completed = current_user.quest_completed.find {|x| x.quest_id == quest.id}
            json.completed ((quest_completed) ? true : false)
            json.completed_at ((quest_completed) ? quest_completed.created_at : nil)
            if quest.steps.count > 0
                json.steps do
                    json.array!(quest.steps) do |step|
                        json.cache! ['v3', step] do
                            json.partial! 'api/v3/steps/step', locals: { step: step }
                        end
                    end
                end
            else
                json.steps nil
            end

            quest.rewards.each do |assigned|
                if assigned.badge
                    json.assigned_badge assigned.badge
                    json.badge do
                        json.cache! ['v3', assigned.badge] do
                            json.partial! 'api/v3/badges/badge', locals: { badge: assigned.badge }
                        end
                    end
                else
                json.badge nil
                end
            end
        end
    end
end
