class Api::V5::CategoriesController < Api::V4::CategoriesController
  def index
    @categories = paginate Category.all
    @categories = @categories.for_super_admin if current_user.super_admin?
    @categories = @categories.for_admin if current_user.admin?
    @categories = @categories.for_staff if current_user.staff?
    @categories = @categories.for_user if current_user.normal?
    @categories = @categories.for_product_account if current_user.product_account?
    return_the @categories, handler: 'jb'
  end

  def show
    @category = Category.find(params[:id])
    return_the @category, handler: 'jb'
  end

  def select
    @categories = Category.pluck(:id, :name).map do |category|
      {
        text: category[1],
        value: category[0]
      }
    end
    if @categories.valid?
      render json: { categories: @categories } && return
    end
    render_error(@categories.error)
  end
end
