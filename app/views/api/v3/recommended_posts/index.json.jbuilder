json.recommended_posts do
  json.array!(@posts) do |post|
    next if post.deleted? && current_user&.app != "portal"
    json.partial! "api/v3/posts/post", locals: { post: post, lang: @lang, post_reaction: @post_reactions[post.id] }
  end
end
