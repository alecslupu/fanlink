# frozen_string_literal: true

json.activity do
  json.partial! 'activity', locals: { activity: @quest_activity }
end
