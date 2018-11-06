class Api::V4::ActionTypesController < Api::V3::ActionTypesController
  def index
    @action_types = paginate(ActionType.all)
    return_the @action_types, handler: 'jb'
  end

  def show
    @action_type = ActionType.find(params[:id]).includes(:rewards)
    return_the @action_type, handler: 'jb'
  end

  def create
    @action_type = ActionType.create(action_params)
    if @action_type.valid?
      return_the @action_type, handler: 'jb'
    else
      render_422 @action_type.errors
    end
  end

  def update
    @action_type = ActionType.find(params[:id])
    if params.has_key?(:action_type)
      @action_type.update_attributes(action_params)
    end
    return_the @action_type, handler: 'jb'
  end
end
