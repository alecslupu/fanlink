class Api::V5::SemestersController < Api::V4::SemestersController
  def index
    if @req_source == "web"
      @semesters = paginate(Semester.where(deleted: false).includes(courses: :lessons)).order(created_at: :asc)
    else
      @semesters = paginate(Semester.available.where(deleted: false).includes(courses: :lessons)).order(created_at: :asc)
    end
    return_the @semesters, handler: "jb"
  end

  def show
    @semester = Semester.includes(courses: :lessons).find(params[:id])
    return_the @semester, handler: "jb"
  end
end
