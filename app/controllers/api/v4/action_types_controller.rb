# frozen_string_literal: true
class Api::V4::ActionTypesController < Api::V3::ActionTypesController
  def index
    @action_types = paginate(ActionType.all)
    return_the @action_types, handler: tpl_handler
  end

  def show
    @action_type = ActionType.includes(:rewards).find(params[:id])
    return_the @action_type, handler: tpl_handler
  end

  def create
    @action_type = ActionType.create(action_params)
    if @action_type.valid?
      return_the @action_type, handler: tpl_handler, using: :show
    else
      render_422 @action_type.errors
    end
  end

  def update
    @action_type = ActionType.find(params[:id])
    if params.has_key?(:action_type)
      @action_type.update(action_params)
    end
    return_the @action_type, handler: tpl_handler, using: :show
  end

  protected

    def tpl_handler
      :jb
    end
end
