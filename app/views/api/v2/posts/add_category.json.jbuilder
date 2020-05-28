# frozen_string_literal: true
json.post do
    json.partial! "api/v1/posts/post", locals: { post: @post, lang: @lang, post_reaction: @post_reaction }
  end
