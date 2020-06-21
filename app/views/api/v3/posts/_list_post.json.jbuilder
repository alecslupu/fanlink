# frozen_string_literal: true

json.cache! ['v3', 'list', post] do
  json.id post.id
  json.person do
    json.partial! 'api/v3/people/person', locals: { person: post.person }
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
  if post.category.present?
    json.category post.category, partial: 'api/v3/categories/category', as: :category
  else
    json.category nil
  end

  if post.tags.count > 0
    json.tags post.tags, partial: 'api/v3/tags/tag', as: :tag
  else
    json.tag nil
  end
end
json.comment_count post.comments.visible.count
