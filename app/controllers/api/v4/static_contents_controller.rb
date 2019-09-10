class Api::V4::StaticContentsController < ApiController
  before_action :set_static_content, only: %i[show]

  def show
    return_the @static_content, handler: tpl_handler
  end

  private

  def set_static_content
    @static_content = StaticContent.find_by(slug: params[:slug])
  end
end
