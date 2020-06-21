# frozen_string_literal: true

class Api::V3::ProductsController < Api::V2::ProductsController
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
    if params.has_key?(:product)
      @product = Product.find(params[:id])
      if @product.update(product_params)
        return_the @product
      else
        render_422 @product.errors
      end
    else
      render_422(_("Update failed. Missing product object."))
    end
  end

# def destroy

# end

private
  def product_params
    params.require(:product).permit(:name, :internal_name, :enabled)
  end
end
