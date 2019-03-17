class Api::V5::LessonsController < Api::V4::LessonsController
  def index
    if web_request?
      @lessons = paginate(@course.lessons.where(deleted: false)).order(created_at: :asc)
    else
      @lessons = paginate(@course.lessons.available.where(deleted: false)).order(created_at: :asc)
    end
    return_the @lessons, handler: tpl_handler
  end

  def show
    return_the @lesson, handler: tpl_handler
  end
end
