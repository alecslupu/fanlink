class Api::V4::CategoriesController < Api::V3::CategoriesController
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

  def create
    @category = Category.create(category_params)
    return_the @category, handler: 'jb'
  end

  def update
    if params.has_key?(:category)
      if @category.update_attributes(category_params)
        broadcast(:category_updated, current_user, @category)
        return_the @category, handler: 'jb'
      else
        render_422 @category.errors
      end
    else
      return_the @category, handler: 'jb'
    end
  end

  def posts
    @posts = paginate Post.for_category(params[:category_name])
    @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)
    return_the @posts, handler: 'jb'
  end
end
