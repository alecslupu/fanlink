# frozen_string_literal: true

json.interests do
  json.array! @interests do |i|
    json.partial! 'interest', locals: { interest: i }
  end
end
