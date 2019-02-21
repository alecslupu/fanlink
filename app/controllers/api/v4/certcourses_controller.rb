class Api::V4::CertcoursesController < ApiController
  load_up_the Certificate, from: :certificate_id

  def index
    @certcourses = paginate @certificate.certcourses
    return_the @certcourses, handler: 'jb'
  end

  def show
    @certificate = Certcourse.find(params[:id])
    return_the @certcourse, handler: 'jb'
  end
end
