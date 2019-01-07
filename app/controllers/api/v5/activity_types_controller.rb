class Api::V5::ActivityTypesController < Api::V4::ActivityTypesController
  def index
    if current_user.some_admin? && @req_source == :web
      @activity_types = @quest_activity.activity_types.order(updated_at: :desc)
    else
      @activity_types = @quest_activity.activity_types.where(deleted: false).order(created_at: :desc)
    end
    return_the @activity_types, handler: 'jb'
  end

  def show
    render_404 unless @activity_type.deleted == false || (current_user.some_admin? && @req_source == :web)
    return_the @activity_type, handler: 'jb'
  end
end
