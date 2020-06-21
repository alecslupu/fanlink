# frozen_string_literal: true

class Api::V3::SemestersController < ApiController
  before_action :admin_only, only: %i[create update delete]
  load_up_the Semester, only: %i[update destroy]

  def index
    if web_request?
      @semesters = paginate(Semester.where(deleted: false).includes(courses: :lessons)).order(created_at: :asc)
    else
      @semesters = paginate(Semester.available.where(deleted: false).includes(courses: :lessons)).order(created_at: :asc)
    end
    return_the @semesters, handler: tpl_handler
  end

  def show
    @semester = Semester.includes(courses: :lessons).find(params[:id])
    return_the @semester, handler: tpl_handler
  end

  def create
    @semester = Semester.create(semester_params)
    if @semester.valid?
      broadcast(:semester_created, current_user, @semester)
    end
    return_the @semester, handler: tpl_handler
  end

  def update
    if @semester.update(semester_params)
      broadcast(:semester_updated, current_user, @semester)
    end
    return_the @semester, handler: tpl_handler
  end

  def destroy
    if some_admin?
      if @semester.update(deleted: true)
        head :ok
      else
        render_422(@semester.errors)
      end
    else
      render_not_found
    end
  end

  protected

    def tpl_handler
      :jb
    end

    def semester_params
      params.require(:semester).permit(:name, :description, :start_date, :end_date)
    end
end
