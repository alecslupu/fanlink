class Api::V4::Trivia::GamesController < ApiController
  def index
    @games = paginate(::Trivia::Game.all)
    return_the @games, handler: 'jb'
  end
end
