# frozen_string_literal: true
class Api::V4::UrlsController < Api::V3::UrlsController
  load_up_the Url, only: %i[ show update delete]
  def index
    @urls = Url.all
    return_the paginate(@urls), handler: tpl_handler
  end

  def show
    if @url.deleted? && !some_admin?
      render_404
    else
      return_the @url, handler: tpl_handler
    end
  end

  def create
    @url = Url.create(url_params)
    broadcast(:url_created, current_user, @url)
    return_the @url, handler: tpl_handler, using: :show
  end

  def update
    @url.update(url_params)
    broadcast(:url_updated, current_user, @url)
    return_the @url, handler: tpl_handler, using: :show
  end

  def destroy
  end

  protected

    def tpl_handler
      :jb
    end

  private
    def url_params
      params.require(:url).permit(:displayed_url, :protected)
    end
end
