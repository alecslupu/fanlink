# frozen_string_literal: true

class Api::V4::LevelsController < Api::V3::LevelsController
  before_action :admin_only, only: %i[ create update destroy ]
  load_up_the Level, only: %i[ update show delete ]
  def index
    @levels = paginate(Level.order(:points))
    return_the @levels, handler: tpl_handler
  end

  # def show
  #   return_the @level, handler: tpl_handler
  # end

  # def create
  #   @level = Level.create(level_params)
  #   broadcast(:level_created, current_user, @level)
  #   return_the @level, handler: tpl_handler, using: :show
  # end

  # def update
  #   binding.pry
  #   @level.update(level_params)
  #   broadcast(:level_updated, current_user, @level)
  #   return_the @level, handler: tpl_handler, using: :show
  # end

  # def destroy
  #   if some_admin?
  #     if @level.update(deleted: true)
  #       head :ok
  #     else
  #       render_422(_("Failed to delete the level."))
  #     end
  #   else
  #     render_not_found
  #   end
  # end

  protected

    def tpl_handler
      :jb
    end

  private
    def level_params
      params.require(:level).permit(:name, :internal_name, :description, :picture, :points)
    end
end
