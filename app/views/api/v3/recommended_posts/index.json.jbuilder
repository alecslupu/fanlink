# frozen_string_literal: true

json.recommended_posts do
  json.array!(@posts) do |post|
    next if post.deleted? && @req_source != "web"
    if %w[ lvconnect nashvilleconnect ].include?(ActsAsTenant.current_tenant.internal_name)
      post.recommended = true
    end
    json.partial! "api/v3/posts/post", locals: { post: post, lang: @lang, post_reaction: @post_reactions[post.id] }
  end
end
