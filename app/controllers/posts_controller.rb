# frozen_string_literal: true

class PostsController < ApplicationController
  caches_page :share, gzip: true

  def share
    product =  Product.find_by(internal_name: params[:product])
    @post = Post.for_product(product).visible.find(params[:post_id])
  end
end
