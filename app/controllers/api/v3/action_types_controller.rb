class Api::V3::ActionTypesController < Api::V3::BaseController
  before_action :super_admin_only, only: %i[ create update destroy ]
  def index
    @action_types = paginate(ActionType.all)
    return_the @action_types
  end

  def show
    @action_type = ActionType.find(params[:id])
    return_the @action_type
  end

  def create
    @action_type = Quest.create(action_params)
    if @action_type.valid?
      return_the @action_type
    else
      render_422 action_type.errors.messages.flatten
    end
  end

  def update
    @action_type = ActionType.find(params[:id])
    @action_type.update_attributes(action_params)
    return_the @action_type
  end

  def destroy
    if current_user.super_admin?
      @action_type = ActionType.find(params[:id])
      if @action_type.in_use?
        render_422 'Action is in use and cannot be deleted.'
      else
        @action_type.destroy
        head :ok
      end
    else
      render_not_found
    end
  end

private
  def action_params
    params.require(:action_type).permit(:name, :internal_name, :seconds_lag, :active)
  end
end
