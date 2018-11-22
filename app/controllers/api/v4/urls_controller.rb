class Api::V4::UrlsController < Api::V3::UrlsController
  load_up_the Url, only: %i[ show update delete]
  def index
    @urls = Url.all
    return_the paginate(@urls), handler: 'jb'
  end

  def show
    if @url.deleted? && !current_user.some_admin?
      render_404
    else
      return_the @url, handler: 'jb'
    end
  end

  def create
    @url = Url.create(url_params)
    broadcast(:url_created, current_user, @url)
    return_the @url, handler: 'jb', using: :show
  end

  def update
    @url.update_attributes(url_params)
    broadcast(:url_updated, current_user, @url)
    return_the @url, handler: 'jb', using: :show
  end

  def destroy
  end

private
  def url_params
    params.require(:url).permit(:displayed_url, :protected)
  end
end
