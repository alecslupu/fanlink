# frozen_string_literal: true
class Api::V3::LessonsController < ApiController
  before_action :admin_only, only: %i[ create update delete ]
  load_up_the Lesson, only: %i[ update show destroy ]
  load_up_the Course, from: :course_id, only: %i[ index create ]

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

  def create
    @lesson = @course.lessons.create(lesson_params)
    if @lesson.valid?
      broadcast(:lesson_created, current_user, @lesson)
    end
    return_the @lesson, handler: tpl_handler
  end

  def update
    if @lesson.update(lesson_params)
      broadcast(:lesson_updated, current_user, @lesson)
    end
    return_the @lesson, handler: tpl_handler
  end

  def destroy
    if some_admin?
      if @lesson.update(deleted: true)
        head :ok
      else
        render_422(@lesson.errors)
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

    def lesson_params
      params.require(:lesson).permit(:name, :description, :start_date, :end_date, :video)
    end
end
