class Api::V4::PersonCertificatesController < ApiController
  before_action :load_person_certificate, only: %i[ update ]
  def create
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

  def update
  	if person_certificate_params[:full_name] && @person_certificate.full_name.blank?
  	  if @person_certificate.update_attributes(person_certificate_params)
        return_the @person_certificate, handler: 'jb', using: :show
      else
        render_422 @person_certificate.errors
      end
  	end
  end

  private

  def load_person_certificate
  	@person_certificate = PersonCertificate.find(params[:person_certificate_id])
  end

  def person_certificate_params
    params.require(:person_certificate).permit(%i[ certificate_id purchased_order_id amount_paid currency purchased_sku purchased_platform full_name ])
  end
end