class Api::V3::SemestersController < Api::V3::BaseController
  before_action :admin_only, only: %i[ create update delete ]
  load_up_the Semester, only: %i[ update show destroy ]

  def index
    @semesters = paginate(Semester.where(deleted: false).includes(courses: :lessons).where(deleted: false))
    return_the @semesters, handler: "jb"
  end

  def show
    return_the @semester, handler: "jb"
  end

  def create
    @semester = Semester.create(semester_params)
    if @semester.valid?
      broadcast(:semester_created, current_user, @semester)
    end
    return_the @semester, handler: "jb"
  end

  def update
    if @semester.update(semester_params)
      broadcast(:semester_updated, current_user, @semester)
    end
    return_the @semester, handler: "jb"
  end

  def destroy
    if current_user.some_admin?
      if @semester.update(deleted: true)
        head :ok
      else
        render_422(@semester.errors)
      end
    else
      render_not_found
    end
  end

private

  def semester_params
    params.require(:semester).permit(:name, :description, :start_date, :end_date)
  end
end
