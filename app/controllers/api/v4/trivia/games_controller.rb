class Api::V4::Trivia::GamesController < ApiController
  def index
    @games = paginate(::Trivia::Game.recent)
    return_the @games, handler: :jb
  end
end
