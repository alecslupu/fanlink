# frozen_string_literal: true

class Api::V4::ProductsController < Api::V3::ProductsController
  def index
    @products = paginate(Product.all)
    return_the @products, handler: tpl_handler
  end

  def show
    @product = Product.find(params[:id])
    return_the @product, handler: tpl_handler
  end

  def create
    @product = Product.create(product_params)
    if @product.valid?
      return_the @product, handler: tpl_handler, using: :show
    else
      render_422 @product.errors
    end
  end

  def update
    if params.has_key?(:product)
      @product = Product.find(params[:id])
      if @product.update(product_params)
        return_the @product, handler: tpl_handler, using: :show
      else
        render_422 @product.errors
      end
    else
      render_422(_('Update failed. Missing product object.'))
    end
  end

  protected

    def tpl_handler
      :jb
    end

    def product_params
      params.require(:product).permit(:name, :internal_name, :enabled, :logo, :color_primary, :color_primary_dark, :color_primary_66, :color_primary_text, :color_secondary, :color_secondary_text, :color_tertiary, :color_tertiary_text, :color_accent, :color_accent_50, :color_accent_text, :color_title_text)
    end
end
