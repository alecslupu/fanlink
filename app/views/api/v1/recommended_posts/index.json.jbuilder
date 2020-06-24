# frozen_string_literal: true

json.recommended_posts @posts, partial: 'api/v1/posts/post', as: :post
