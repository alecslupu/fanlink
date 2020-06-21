# frozen_string_literal: true

json.quest do
  json.partial! "quest", locals: { quest: @quest, lang: nil }
end
