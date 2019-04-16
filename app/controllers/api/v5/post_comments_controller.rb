class Api::V5::PostCommentsController < Api::V4::PostCommentsController
  def index
    @post_comments = paginate @post.comments.visible.order(created_at: :desc)
    return_the @post_comments, handler: tpl_handler
  end

  protected

    def tpl_handler
      :jb
    end
end
