class Api::V4::ProductsController < Api::V4::BaseController
  before_action :super_admin_only

  def select
    @products = Product.all
    return_the @products
  end

  def index
    @products = paginate(Product.all)
    return_the @products
  end

  def create
    @product = Product.create(product_params)
    if @product.valid?
      return_the @product
    else
      render_422 @product.errors
    end
  end

  def show
    @product = Product.find(params[:id])
    return_the @product
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      return_the @product
    else
      render_422 @product.errors
    end
  end

# def destroy

# end

private
  def product_params
    params.require(:product).permit(:name, :internal_name, :enabled)
  end
end
