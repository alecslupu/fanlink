class Api::V4::PostCommentsController < Api::V3::PostCommentsController
  def index
    @post_comments = paginate @post.comments.visible.order(created_at: :desc)
    return_the @post_comments, handler: 'jb'
  end

  def list
    @post_comments = paginate apply_filters
    return_the @post_comments, handler: 'jb'
  end

  def create
    if current_user.chat_banned?
      render json: { errors: "You are banned." }, status: :unprocessable_entity
    else
      @post_comment = @post.post_comments.create(post_comment_params)
      if @post_comment.valid?
        @post_comment.post_me()
        return_the @post_comment, handler: 'jb', using: :show
      else
        render_422 @post_comment.errors
      end
    end
  end
end
