# frozen_string_literal: true
class Api::V3::CoursesController < ApiController
  before_action :admin_only, only: %i[ create update delete ]
  load_up_the Course, only: %i[ update destroy ]
  load_up_the Semester, from: :semester_id, only: %i[ index create ]

  def index
    if web_request?
      @courses = paginate(@semester.courses.where(deleted: false).includes(:lessons)).order(created_at: :asc)
    else
      @courses = paginate(@semester.courses.available.where(deleted: false).order(created_at: :asc).includes(:lessons))
    end
    return_the @courses, handler: tpl_handler
  end

  def show
    @course = Course.includes(:lessons).find(params[:id])
    return_the @course, handler: tpl_handler
  end

  def create
    @course = @semester.courses.create(course_params)
    if @course.valid?
      broadcast(:course_created, current_user, @course)
    end
    return_the @course, handler: tpl_handler
  end

  def update
    if @course.update(course_params)
      broadcast(:course_updated, current_user, @course)
    end
    return_the @course, handler: tpl_handler
  end

  def destroy
    if some_admin?
      if @course.update(deleted: true)
        head :ok
      else
        render_422(@course.errors)
      end
    else
      render_not_found
    end
  end

  protected

    def tpl_handler
      :jb
    end

  private

    def course_params
      params.require(:course).permit(:name, :description, :start_date, :end_date)
    end
end
