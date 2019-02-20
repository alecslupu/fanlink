class Api::V4::CertcoursesController < ApiController
  def index
    @certcourses = paginate Certcourse.all
    #return_the @certcourses, handler: 'jb'
    render json: {message: "This will be the Certcourse index"}
  end

  def show
    @certificate = Certcourse.find(params[:id])
    #return_the @certcourse, handler: 'jb'
    render json: {message: "This will be the Certcourse show page"}
  end
end
