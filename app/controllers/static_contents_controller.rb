class StaticContentsController < ApplicationController
  caches_page :post_share, gzip: true
  caches_page :html_content, gzip: true
  before_action :set_static_content, only: %i[html_content]

  def html_content
  end

  def post_share
    product =  Product.find_by(internal_name: params[:product])
    post = Post.for_product(product).visible.find(params[:post_id])
    @locals = generate_locals(post)
  end

  private

  def set_static_content
    product = Product.where(internal_name: params[:product]).first
    raise ActionController::RoutingError.new('Invalid Product') if product.nil?
    @static_content = StaticContent.find_by(slug: params[:slug], product_id: product.id)
    raise ActionController::RoutingError.new("Invalid slug parameter: #{product.internal_name}/static/:slug") if@static_content.nil?
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


