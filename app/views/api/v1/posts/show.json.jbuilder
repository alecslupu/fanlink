json.post do
  json.partial! "post", locals: { post: @post, post_reaction: @post_reaction }
end
