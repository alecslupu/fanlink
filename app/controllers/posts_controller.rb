class PostsController < ApplicationController
  caches_page :share, gzip: true

  def share
    product = get_product
    # if product.nil?
      # render_422(_("Missing or invalid product."))
    # else
      @post = Post.for_product(product).visible.find(params[:post_id])
    # end
  end

  private

  def get_product
    product = nil
      if params[:product].present?
      product = Product.find_by(internal_name: params[:product])
    end
    product
  end
end
