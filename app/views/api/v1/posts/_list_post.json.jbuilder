# frozen_string_literal: true
json.id post.id.to_s
json.person do
  json.partial! "api/v1/people/person", locals: { person: post.person }
end
json.body post.body
json.picture_url post.picture_optimal_url
json.global post.global
json.starts_at post.starts_at.to_s
json.ends_at post.ends_at.to_s
json.repost_interval post.repost_interval
json.status post.status
json.priority post.priority
json.recommended post.recommended
json.created_at post.created_at.to_s
json.updated_at post.updated_at.to_s
json.comment_count post.comments.count
if !post.category.nil?
  json.category post.category, partial: "api/v2/categories/category", as: :category
else
  json.category nil
end

if post.tags.count > 0
  json.tags post.tags, partial: "api/v2/tags/tag", as: :tag
else
  json.tag nil
end
