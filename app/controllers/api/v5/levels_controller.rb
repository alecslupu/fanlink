class Api::V5::LevelsController < Api::V4::LevelsController
  def index
    @levels = paginate(Level.order(:points))
    return_the @levels, handler: 'jb'
  end

  def show
    return_the @level, handler: 'jb'
  end
end
