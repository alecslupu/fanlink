# frozen_string_literal: true

json.cache! ['v3', post_comment] do
  json.id post_comment.id.to_s
  json.post_id post_comment.post_id
  json.person_id post_comment.person_id
  json.body post_comment.body
  json.hidden post_comment.hidden
  json.created_at post_comment.created_at.to_s
  json.updated_at post_comment.updated_at.to_s
  if post_comment.mentions.count > 0
    json.mentions post_comment.mentions, partial: 'api/v3/post_comments/mention', as: :mention
  else
    json.mentions nil
  end
end
