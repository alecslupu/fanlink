# frozen_string_literal: true

json.post do
  json.id @post.id
  json.body @post.body
  json.picture_url AttachmentPresenter.new(@post.picture).url
  json.status @post.status
  json.person do
    json.username @post.person.username
    json.picture_url AttachmentPresenter.new(@post.person.picture).url
  end
end
