class Api::V4::Trivia::RoundsController < ApiController
  def index
    @packages = paginate(::Trivia::Game.find(params[:game_id]).rounds.visible)
    return_the @packages, handler: :jb
  end
end
