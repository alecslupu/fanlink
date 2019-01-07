class Api::V5::UrlsController < Api::V4::UrlsController
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
end
