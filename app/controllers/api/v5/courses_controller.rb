class Api::V5::CoursesController < Api::V4::CoursesController
  def index
    if @req_source == "web"
      @courses = paginate(@semester.courses.where(deleted: false).includes(:lessons)).order(created_at: :asc)
    else
      @courses = paginate(@semester.courses.available.where(deleted: false).order(created_at: :asc).includes(:lessons))
    end
    return_the @courses, handler: "jb"
  end

  def show
    @course = Course.includes(:lessons).find(params[:id])
    return_the @course, handler: "jb"
  end
end
