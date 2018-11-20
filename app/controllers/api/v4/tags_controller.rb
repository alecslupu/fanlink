class Api::V4::TagsController < Api::V3::TagsController
  def index
    if params[:tag_name].present?
      @posts = paginate Post.visible.for_tag(params[:tag_name])
      return_the @posts, handler: 'jb'
    elsif current_user.some_admin? && @req_source == 'web'
      @tags = paginate Tag.all
      return_the @tags, handler: 'jb'
    else
      render_422 _("Parameter tag_name is required.")
    end
  end

end
