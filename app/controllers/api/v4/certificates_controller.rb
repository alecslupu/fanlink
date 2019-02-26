class Api::V4::CertificatesController < ApiController
  def index
    @certificates = paginate Certificate.order("certificate_order")
    return_the @certificates, handler: 'jb'
  end

  def show
    @certificate = Certificate.find(params[:id])
    return_the @certificate, handler: 'jb', using: :show
  end
end
