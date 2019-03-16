class Api::V5::ProductsController < Api::V4::ProductsController
  def index
    @products = paginate(Product.all)
    return_the @products, handler: tpl_handler
  end

  def show
    @product = Product.find(params[:id])
    return_the @product, handler: tpl_handler
  end

  def setup
    @product = Product.find_by(internal_name: params[:internal_name])
    return_the @product, handler: tpl_handler
  end
end
