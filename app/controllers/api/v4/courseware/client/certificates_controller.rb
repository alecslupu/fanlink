class Api::V4::Courseware::Client::CertificatesController < ApiController

  # o sa dai certificarile persoane cu id-ul params[:person_id]
  # PersonCertificate.last.issued_certificate_image.url poza

  def index
    @certificates = Person.find(params[:person_id]).certificates
    return_the @certificates, handler: :jb
  end

  def download
    @url = "https://s3.us-east-1.amazonaws.com/fanlink-staging/caned/certificates/template_images/000/000/086/original/76ba71377a4b46a2d2c72921c0e62bc3b3b9d6cf.jpg?1571836879"
  end

  def send_email
    render json: { message: _("Email sent") }
  end
end
