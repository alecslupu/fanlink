# frozen_string_literal: true

json.interest do
  json.partial! 'api/v3/interests/interest', locals: { interest: @interest, lang: nil }
end
