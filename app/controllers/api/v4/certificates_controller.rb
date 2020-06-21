# frozen_string_literal: true

class Api::V4::CertificatesController < ApiController
  def create
    @certificate = Certificate.create(certificate_params)
    return_the @certificate, handler: tpl_handler, using: :show
  end

  def index
    @certificates = paginate Certificate.live_status.order(:certificate_order)
    return_the @certificates, handler: tpl_handler
  end

  def show
    @certificate = Certificate.find(params[:id])
    return_the @certificate, handler: tpl_handler, using: :show
  end

  def send_certificate
    @person_certificate = Certificate.find(params[:id]).for_person(@current_user)
    @current_user.send_certificate_email(@person_certificate)
  end

  protected

    def tpl_handler
      "jb"
    end

  private

    def certificate_params
      params.require(:certificate).permit(%i[long_name short_name description certificate_order template_image])
    end
end
