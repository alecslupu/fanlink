class Api::V4::CertificatesController < ApiController
  def index
    @certificates = paginate Certificate.all
    #return_the @certificates, handler: 'jb'
    render json: {message: "This will be the Certificate index"}
  end

  def show
    @certificate = Certificate.find(params[:id])
    #return_the @certificate, handler: 'jb'
    render json: {message: "This will be the Certificate show page"}
  end
end
