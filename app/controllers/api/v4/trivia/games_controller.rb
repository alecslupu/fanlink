class Api::V4::Trivia::GamesController < ApiController
  def index
    @games = paginate(data_source.upcomming)
    return_the @games, handler: :jb
  end

  def completed
    @games = paginate(data_source.completed)
    return_the @games, handler: :jb
  end


  protected

  def data_source
    ::Trivia::Game.includes(:subscribers).where(subscribers: { person_id: current_user.id })
  end
end
