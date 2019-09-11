class Api::V4::StaticContentsController < ApiController
  before_action :set_static_content, only: %i[show]

  def show
    if @static_content.present?
      return_the @static_content, handler: :jb
    else
      render_not_found
    end
  end

  private

  def set_static_content
    @static_content = StaticContent.find_by(slug: params[:slug])
  end
end
