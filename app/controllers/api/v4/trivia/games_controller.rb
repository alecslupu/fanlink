class Api::V4::Trivia::GamesController < ApiController
  def index
    @games = paginate(data_source.upcomming, per_page: 100)
    # return_the @games, handler: :jb, using: :index
    render :index, handler: :jb
  end

  def completed
    @games = paginate(data_source.completed, per_page: 100)
    render :index, handler: :jb
  end


  protected

  def data_source
    ::Trivia::Game.includes(:subscribers).where(trivia_subscribers: { person_id: [ current_user.id, nil ] })
  end
end
