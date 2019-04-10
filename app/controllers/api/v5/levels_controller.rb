class Api::V5::LevelsController < Api::V4::LevelsController
  def index
    @levels = paginate(Level.order(:points))
    return_the @levels, handler: tpl_handler
  end

  def show
    return_the @level, handler: tpl_handler
  end
end
