# frozen_string_literal: true

json.post do
  json.partial! 'post', locals: { post: @post, lang: nil }
end
