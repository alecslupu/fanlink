class StaticContentsController < ApplicationController
  caches_page :post_share, gzip: true
  before_action :set_static_content, only: %i[show]

  def show
  end

  def post_share
    product =  Product.find_by(internal_name: params[:product])
    post = Post.for_product(product).visible.find(params[:post_id])
    @locals = generate_locals(post)
  end

  private

  def set_static_content
    @static_content = StaticContent.find_by(slug: params[:slug], product_id: params[:product_id])
  end

  def generate_locals(post)
    {
      body: post.body.present? ? post.body.html_safe : "",
      title: "Check out this post on #{post.product.name}!",
      post_image_url: post.picture.exists? ? post.picture.url : "https://fanlinkmusic.com/static/img/pattern-2.487c258.jpg",
      # post_url: "#{root_url}/download/#{product.internal_name}",
      user_image_url: post.person.picture.exists? ? post.person.picture.url : "https://fanlinkmusic.com/static/img/pattern-2.487c258.jpg",
      username: post.person.username
    }
  end
end


