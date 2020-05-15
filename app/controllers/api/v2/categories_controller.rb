class Api::V2::CategoriesController < ApiController
  load_up_the Category, only: %i[ update delete ]
  # **
  # @apiDefine V2CategoryObject
  #    description
  # *

  # **
  # @apiDefine V2CategoryArray
  #    description
  # *

  # **
  #
  # @api {get} /categories Get Categories for Product
  # @apiName GetCategories
  # @apiGroup Categories
  # @apiVersion  2.0.0
  #
  #
  # @apiParam  {String} [product] The product to get the categories for.
  #
  #
  # @apiParamExample  {type} Request-Example:
  # {
  #     property : value
  # }
  #
  #
  # @apiUse V2CategoryArray
  #
  #
  # *
  def index
    @categories = Category.all
    @categories = @categories.for_super_admin if current_user.super_admin?
    @categories = @categories.for_admin if current_user.admin?
    @categories = @categories.for_staff if current_user.staff?
    @categories = @categories.for_user if current_user.normal?
    @categories = @categories.for_product_account if current_user.product_account?
    return_the @categories
  end

  # **
  #
  # @api {get} /categories/:id title
  # @apiName apiName
  # @apiGroup group
  # @apiVersion  2.0.0
  #
  #
  # @apiParam  {Number} id ID of the category
  #
  # @apiSuccess (200) {object} Category Category Object
  #
  # @apiParamExample  {type} Request-Example:
  # {
  #     property : value
  # }
  #
  #
  # @apiUse V2CategoryObject
  #
  #
  # *

  def show
    @category = Category.find(params[:id])
    return_the @category
  end

  # **
  #
  # @api {post} /categories Create Category
  # @apiName CreateCategory
  # @apiGroup Categories
  # @apiVersion  2.0.0
  #
  #
  # @apiParam  {Object} Category Category Container
  # @apiParam  {String} name Category Name
  # @apiParam  {String} color Color code hex
  # @apiParam  {String} role Minimum allowed role to access the category
  #
  #
  # @apiParamExample  {type} Request-Example:
  # {
  #     property : value
  # }
  #
  #
  # @apiUse V2CategoryObject
  #
  #
  # *

  def create
    @category = Category.create(category_params)
    if @category.valid?
      return_the @category
    else
      render json: { errors: @category.errors.messages }, status: :unprocessable_entity
    end
  end

  # **
  #
  # @api {patch} /category/:id Update a category
  # @apiName UpdateCategory
  # @apiGroup Categories
  # @apiVersion  2.0.0
  #
  #
  # @apiParam  {Object} category Category container
  # @apiParam  {String} name Category Name
  # @apiParam  {String} color Color code hex
  # @apiParam  {String} role Minimum allowed role to access the category
  #
  #
  # @apiParamExample  {type} Request-Example:
  # {
  #     property : value
  # }
  #
  #
  # @apiUse V2CategoryObject
  #
  #
  # *

  def update
    if @category.update(category_params)
      broadcast(:category_updated, current_user, @category)
      return_the @category
    else
      render json: { errors: @category.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if some_admin?
      if current_user.super_admin? && param[:force] == "1"
        @category.destroy
        head :ok
      else
        if @category.update(deleted: true)
          @category.posts.each do | post |
            post.category_id = nil
          end
          head :ok
        else
          render_422 @category.errors
        end
      end
    else
      render_not_found
    end
  end

  def search
  end

private
  def category_params
    params.require(:category).permit(:name, :color, :role)
  end
end
