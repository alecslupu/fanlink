json.id post.id.to_s
json.create_time post.created_at.to_s
json.body post.body(lang)
json.picture_url post.picture_url
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
