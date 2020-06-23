# frozen_string_literal: true

json.type do
  json.partial! 'type', locals: { atype: @activity_type, lang: nil }
end
