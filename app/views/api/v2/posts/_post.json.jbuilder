json.id post.id.to_s
json.create_time post.created_at.to_s
json.body post.body
json.picture_url post.picture_optimal_url
json.audio_url post.audio_url
json.audio_size post.audio_file_size
json.audio_content_type post.audio_content_type
json.person do
  json.partial! "api/v1/people/person", locals: { person: post.person, relationships: Relationship.for_people(current_user, post.person) }
end
json.post_reaction_counts post.reaction_breakdown.to_json
if defined?(post_reaction) && post_reaction.present?
  json.post_reaction post_reaction, partial: "api/v1/post_reactions/post_reaction", as: :post_reaction
else
  json.post_reaction nil
end
json.global post.global
json.starts_at (post.starts_at.nil?) ? nil : post.starts_at.to_s
json.ends_at (post.ends_at.nil?) ? nil : post.ends_at.to_s
json.repost_interval post.repost_interval
json.status post.status
json.priority post.priority
json.recommended post.recommended
json.notify_followers post.notify_followers
json.comment_count post.comments.count
if !post.category.nil?
  json.category do
    json.id post.category.id
    json.name post.category.name
    json.color post.category.color
    json.role post.category.role
  end
else
  json.category do
    json.name nil
  end
end
if post.tags.count > 0
  json.tags post.tags, partial: "api/v2/tags/tag", as: :tag
else
  json.tag nil
end
