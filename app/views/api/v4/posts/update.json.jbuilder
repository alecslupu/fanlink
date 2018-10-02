json.post do
  json.partial! "post", locals: { post: @post, lang: nil }
end
