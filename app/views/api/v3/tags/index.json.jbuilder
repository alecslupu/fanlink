# frozen_string_literal: true

json.posts @posts, partial: "api/v3/posts/post", as: :post
