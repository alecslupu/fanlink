# frozen_string_literal: true
class Api::V4::TagsController < Api::V3::TagsController
  def index
    if params[:tag_name].present?
      @posts = paginate Post.visible.for_tag(params[:tag_name])
      return_the @posts, handler: tpl_handler
    elsif some_admin? && web_request?
      @tags = paginate Tag.all
      return_the @tags, handler: tpl_handler
    else
      render_422 _("Parameter tag_name is required.")
    end
  end

  protected

    def tpl_handler
      :jb
    end
end
