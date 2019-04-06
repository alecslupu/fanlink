class Api::V4::Trivia::PrizesController < ApiController
  def index
    @prizes = paginate(::Trivia::Game.find(params[:game_id]).prizes.published)
    return_the @prizes, handler: :jb
  end
end
