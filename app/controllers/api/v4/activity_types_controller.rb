class Api::V4::ActivityTypesController < Api::V3::ActivityTypesController
  def index
    if some_admin? && web_request?
      @activity_types = @quest_activity.activity_types.order(updated_at: :desc)
    else
      @activity_types = @quest_activity.activity_types.where(deleted: false).order(created_at: :desc)
    end
    return_the @activity_types, handler: tpl_handler
  end

  def show
    render_404 unless @activity_type.deleted == false || (some_admin? && web_request?)
    return_the @activity_type, handler: tpl_handler
  end

  def create
    @activity_type = @quest_activity.activity_types.create(type_params)
    if @activity_type.valid?
      return_the @activity_type, handler: tpl_handler, using: :show
    else
      render_422 @activity_type.errors
    end
  end

  def update
    if params.has_key?(:action_type)
      if @activity_type.update(type_params)
        return_the @activity_type, handler: tpl_handler, using: :show
      else
        render_422 @activity_type.errors
      end
    else
      return_the @activity_type, handler: tpl_handler, using: :show
    end
  end

  protected

    def tpl_handler
      :jb
    end
end
