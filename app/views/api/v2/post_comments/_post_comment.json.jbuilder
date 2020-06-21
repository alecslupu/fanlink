# frozen_string_literal: true

json.id post_comment.id.to_s
json.create_time post_comment.created_at.to_s
json.body post_comment.body
if post_comment.mentions.count > 0
  json.mentions post_comment.mentions, partial: "api/v1/post_comments/mention", as: :mention
else
  json.mentions nil
end
json.person do
  json.partial! "api/v1/people/person", locals: { person: post_comment.person, relationships: Relationship.for_people(current_user, post_comment.person) }
end
