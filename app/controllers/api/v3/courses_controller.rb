class Api::V3::CoursesController < Api::V3::BaseController
  before_action :admin_only, only: %i[ create update delete ]
  load_up_the Course, only: %i[ update show destroy ]
  load_up_the Semester, from: :semester_id, only: %i[ index create ]

  def index
    @courses = paginate(@semester.courses.where(deleted: false).includes(:lessons).where(deleted: false))
    return_the @courses, handler: "jb"
  end

  def show
    return_the @course, handler: "jb"
  end

  def create
    @course = @semester.courses.create(course_params)
    if @course.valid?
      broadcast(:course_created, current_user, @course)
    end
    return_the @course, handler: "jb"
  end

  def update
    if @course.update(course_params)
      broadcast(:course_updated, current_user, @course)
    end
    return_the @course, handler: "jb"
  end

  def destroy
    if current_user.some_admin?
      if @course.update(deleted: true)
        head :ok
      else
        render_422(@course.errors)
      end
    else
      render_not_found
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :start_date, :end_date)
  end
end
