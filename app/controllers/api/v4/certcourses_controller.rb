class Api::V4::CertcoursesController < ApiController
  load_up_the Certificate, from: :certificate_id

  def index
    @certcourses = paginate @certificate.certcourses.live_status.order("certcourse_order")
    return_the @certcourses, handler: 'jb'
  end

  def show
    @certcourse = Certcourse.find(params[:id])
    return_the @certcourse, handler: 'jb'
  end

  def destroy
    @person_certificate = PersonCertcourse.find_by(person_id: @current_user.id, certcourse_id: params[:id])
    @person_certificate.destroy
    render json: { message: _("Deleted") }
  end
end
