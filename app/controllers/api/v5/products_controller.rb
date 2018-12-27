class Api::V5::ProductsController < Api::V4::ProductsController
  def setup
    @product = Product.find_by(internal_name: params[:internal_name])
    return_the @product, handler: "jb"
  end
end
