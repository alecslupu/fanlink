class Api::V5::ActionTypesController < Api::V4::ActionTypesController
  def index
    @action_types = paginate(ActionType.all)
    if web_request?
      if stale?(@action_types)
        return_the @action_types, handler: tpl_handler
      end
    else
      return_the @action_types, handler: tpl_handler
    end
  end

  def show
    @action_type = ActionType.includes(:rewards).find(params[:id])
    if web_request?
      if stale?(@action_type)
        return_the @action_type, handler: tpl_handler
      end
    else
      return_the @action_type, handler: tpl_handler
    end
  end
end
