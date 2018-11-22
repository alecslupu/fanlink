class Api::V4::ProductsController < Api::V3::ProductsController
  def index
    @products = paginate(Product.all)
    return_the @products, handler: 'jb'
  end

  def show
    @product = Product.find(params[:id])
    return_the @product, handler: 'jb'
  end

  def create
    @product = Product.create(product_params)
    if @product.valid?
      return_the @product, handler: 'jb', using: :show
    else
      render_422 @product.errors
    end
  end

  def update
    if params.has_key?(:product)
      @product = Product.find(params[:id])
      if @product.update_attributes(product_params)
        return_the @product, handler: 'jb', using: :show
      else
        render_422 @product.errors
      end
    else
      render_422(_("Update failed. Missing product object."))
    end
  end
end
