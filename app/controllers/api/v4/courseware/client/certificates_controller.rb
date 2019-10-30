class Api::V4::Courseware::Client::CertificatesController < ApiController
  # frozen_string_literal: true
  before_action :load_person_certificate, only: [:download, :send_email]
  def index
    @certificates = Person.find(certificate_params[:person_id]).certificates
    return_the @certificates, handler: :jb
  end

  def download
    if @person_certificate.issued_certificate_image.present?
      @url = @person_certificate.issued_certificate_image.url
      return_the @url, handler: :jb
    else
      render_422 _("This user does not have a image attached to this certificate.")
    end
  end

  def send_email
    if @person_certificate.issued_certificate_pdf.present?
      render json: { message: _("Email sent") }
    else
      render_422 _("This user does not have a pdf file attached to this certificate.")
    end
  end

  private

    def load_person_certificate
      @person_certificate = PersonCertificate.where(certificate_id: certificate_params[:certificate_id], person_id: certificate_params[:person_id])
      render_404 if @person_certificate.blank?
    end

    def certificate_params
      params.require(:certificate).permit(:certificate_id, :person_id)
    end
end
