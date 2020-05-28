# frozen_string_literal: true
json.id category.id
json.name category.name
json.product_id category.product_id.to_s
json.color category.color
json.role category.role.to_s
if category.posts.count > 0
  json.posts category.posts, partial: "api/v1/posts/post", as: :post
else
  json.posts nil
end
