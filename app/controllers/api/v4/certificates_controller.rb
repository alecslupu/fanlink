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

  private

  def certificate_params
    params.require(:certificate).permit(%i[ long_name short_name description certificate_order template_image ])
  end
end
