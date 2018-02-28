json.post do
  json.partial! "post", locals: { post: @post, lang: @lang }
end
