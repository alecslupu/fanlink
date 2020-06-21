# frozen_string_literal: true

json.posts do
  json.array!(@posts) do |post|
    json.cache! ["v3", post, @lang] do
      json.partial! "post", locals: { post: post, lang: @lang, post_reaction: @post_reactions[post.id] }
    end
  end
end
