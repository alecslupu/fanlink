class Api::V5::RecommendedPostsController < Api::V4::RecommendedPostsController
  def index
    if %w[ lvconnect nashvilleconnect ].include?(ActsAsTenant.current_tenant.internal_name)
      @posts = paginate Post.for_product(ActsAsTenant.current_tenant).visible.order(created_at: :desc)
    else
      @posts = paginate Post.for_product(ActsAsTenant.current_tenant).visible.where(recommended: true).order(created_at: :desc)
    end
    @post_reactions = current_user.post_reactions.where(post_id: @posts).index_by(&:post_id)
    return_the @posts, handler: 'jb'
  end
end
