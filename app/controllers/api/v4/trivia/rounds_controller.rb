class Api::V4::Trivia::RoundsController < ApiController
  def index
    @packages = paginate(::Trivia::Game.find(params[:game_id]).question_packages.published)
    return_the @packages, handler: :jb
  end
end
