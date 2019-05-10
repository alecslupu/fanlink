class Api::V4::Trivia::GamesController < ApiController
  def index
    @games = paginate(::Trivia::Game.upcomming)
    return_the @games, handler: :jb
  end

  def completed
    @games = paginate(::Trivia::Game.completed)
    return_the @games, handler: :jb
  end
end
