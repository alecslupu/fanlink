class Api::V4::Trivia::GamesController < ApiController
  def index
    @games = paginate(::Trivia::Game.running)
    return_the @games, handler: :jb
  end

  def scheduled
    @games = paginate(::Trivia::Game.scheduled)
    return_the @games, handler: :jb
  end

  def past
    @games = paginate(::Trivia::Game.past)
    return_the @games, handler: :jb
  end
end
