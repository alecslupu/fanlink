json.post_poll_option do
  json.partial! "post_poll_option", locals: { post_poll_option: @post_poll_option }
end
