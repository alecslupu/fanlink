class Api::V4::PersonCertificatesController < ApiController
  require 'rmagick'
  include Magick

  load_up_the Certificate, from: :certificate_id

  def create
    @person_certificate = PersonCertificate.find_by(certificate_id: params[:certificate_id],person_id: @current_user.id)
    if @person_certificate
      if @person_certificate.full_name.blank?
        @person_certificate.update_attributes(person_certificate_params)
        @person_certificate.reload.write_files
        return_the @certificate, handler: 'jb'
      else
        render_422(_("User already completed the full name"))
      end
    else
    	@person_certificate = PersonCertificate.new(person_certificate_params)
    	@person_certificate.person_id = @current_user.id
    	@person_certificate.unique_id = Digest::SHA1.hexdigest(person_certificate_params.to_s)
    	if @person_certificate.valid?
    	  @person_certificate.save
    	  @certificate = Certificate.find(person_certificate_params[:certificate_id])
        return_the @certificate, handler: 'jb'
      else
        render_422(_("Something went wrong."))
      end
    end
  end

  private

  def person_certificate_params
    params.require(:person_certificate).permit(%i[ certificate_id purchased_order_id amount_paid currency purchased_sku purchased_platform receipt_id full_name ])
  end
end
