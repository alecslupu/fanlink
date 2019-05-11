class Api::V4::Trivia::GamesController < ApiController
  def index
    @games = data_source.upcomming
    # return_the @games, handler: :jb, using: :index
    render :index, handler: :jb
  end

  def completed
    @games = data_source.completed
    render :index, handler: :jb
  end


  protected

  def data_source
    ::Trivia::Game.includes(:subscribers).where(trivia_subscribers: { person_id: current_user.id })
  end
end
