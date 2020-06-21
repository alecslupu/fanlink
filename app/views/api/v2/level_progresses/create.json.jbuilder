# frozen_string_literal: true

json.level_progress do
  json.partial! 'level_progress', locals: { progress: @level_progress, lang: nil }
end
