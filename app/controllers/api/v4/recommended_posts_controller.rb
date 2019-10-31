class Api::V4::RecommendedPostsController < Api::V3::RecommendedPostsController
  def index
    if %w[ lvconnect nashvilleconnect ].include?(ActsAsTenant.current_tenant.internal_name)
      @posts = paginate Post.for_product(ActsAsTenant.current_tenant).visible.order(created_at: :desc), per_page: 250
    else
      @posts = paginate Post.for_product(ActsAsTenant.current_tenant).visible.where(recommended: true).order(created_at: :desc), per_page: 250
    end
    @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)

    return_the @posts, handler: tpl_handler
  end

  protected

    def tpl_handler
      "jb"
    end
end
