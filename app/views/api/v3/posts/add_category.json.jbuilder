json.post do
  json.partial! "api/v3/posts/post", locals: { post: @post, lang: @lang, post_reaction: @post_reaction }
end
