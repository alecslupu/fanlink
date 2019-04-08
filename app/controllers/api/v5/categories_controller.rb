class Api::V5::CategoriesController < Api::V4::CategoriesController
  def index
    @categories = paginate Category.all
    @categories = @categories.for_super_admin if current_user.super_admin?
    @categories = @categories.for_admin if current_user.admin?
    @categories = @categories.for_staff if current_user.staff?
    @categories = @categories.for_user if current_user.normal?
    @categories = @categories.for_product_account if current_user.product_account?
    return_the @categories, handler: tpl_handler
  end

  def show
    @category = Category.find(params[:id])
    return_the @category, handler: tpl_handler
  end

  def select
    @categories = Category.all
    @categories = @categories.for_super_admin if current_user.super_admin?
    @categories = @categories.for_admin if current_user.admin?
    @categories = @categories.for_staff if current_user.staff?
    @categories = @categories.for_user if current_user.normal?
    @categories = @categories.for_product_account if current_user.product_account?
    @categories = @categories.map do |category|
      {
        text: category.name(@lang),
        value: category.id
      }
    end
    render json: {categories: @categories}
  end
end
