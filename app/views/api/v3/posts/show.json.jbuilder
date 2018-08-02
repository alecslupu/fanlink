json.post do
  json.cache! ["v3", @post], expires_in: 10.minutes do
    json.partial! "post", locals: { post: @post, lang: @lang, post_reaction: @post_reaction }
  end
end
