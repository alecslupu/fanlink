class Api::V5::SemestersController < Api::V4::SemestersController
  def index
=begin
    TODO: Refactor this to the following

    @semesters =  Semester.where(deleted: false).includes(courses: :lessons).order(created_at: :asc)
    @semesters.send(:available) unless web_request?
    return_the paginate @semesters, handler: :jb
=end
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

  protected

    def tpl_handler
      "jb"
    end
end
