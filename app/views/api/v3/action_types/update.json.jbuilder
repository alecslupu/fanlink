# frozen_string_literal: true

json.action do
  json.partial! 'action_type', locals: { action: @action_type, lang: nil }
end
