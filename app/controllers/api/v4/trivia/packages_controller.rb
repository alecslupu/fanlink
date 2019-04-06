class Api::V4::Trivia::PackagesController < ApiController
  def index
    @packages = paginate(::Trivia::Game.find(params[:game_id]).packages.published)
    return_the @packages, handler: :jb
  end
end
