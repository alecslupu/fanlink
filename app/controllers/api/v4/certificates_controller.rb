class Api::V4::CertificatesController < ApiController
  def create
  	@certificate = Certificate.create(certificate_params)
  	return_the @certificate, handler: 'jb', using: :show
  end

  def index
    @certificates = paginate Certificate.live_status.order("certificate_order")
    return_the @certificates, handler: 'jb'
  end

  def show
    @certificate = Certificate.find(params[:id])
    return_the @certificate, handler: 'jb', using: :show
  end

  # TODO move it to PersonCertificate# destroy method
  # TODO Assess if is required in prod
  def destroy
    @person_certificate = PersonCertificate.find_by(person_id: @current_user.id, certificate_id: params[:id])
    @person_certificate.destroy
    render json: { message: _("Deleted") }
  end

  def send_certificate
    @person_certificate = Certificate.find(params[:id]).for_person(@current_user)
    @current_user.send_certificate_email(@person_certificate)
  end

  private

  def certificate_params
    params.require(:certificate).permit(%i[ long_name short_name description certificate_order template_image ])
  end
end
