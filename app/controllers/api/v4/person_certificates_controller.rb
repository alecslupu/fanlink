class Api::V4::PersonCertificatesController < ApiController
  require "rmagick"
  include Magick

  load_up_the Certificate, from: :certificate_id
  skip_before_action :require_login, :check_banned, only: [ :show ]

  def create
    @person_certificate = PersonCertificate.find_by(certificate_id: params[:certificate_id], person_id: @current_user.id)
    if @person_certificate
      if @person_certificate.full_name.blank?
        @person_certificate.update_attributes(person_certificate_params)
        @person_certificate.issued_date = DateTime.now if @person_certificate.issued_date.empty?
        @person_certificate.write_files
        return_the @certificate.reload, handler: "jb"
      else
        render_422(_("User already completed the full name"))
      end
    else
      @person_certificate = PersonCertificate.new(person_certificate_params)
      @person_certificate.person_id = @current_user.id
      if @person_certificate.valid?
        @person_certificate.save
        @certificate = Certificate.find(person_certificate_params[:certificate_id])
        return_the @certificate, handler: tpl_handler
      else
        render_422(_("Something went wrong."))
      end
    end
  end


  # def create
  #   @person_certificate = PersonCertificate.where(certificate_id: params[:certificate_id], person_id: current_user.id).first_or_initialize
  #   if @person_certificate.new_record?
  #     @person_certificate.assign_attributes(person_certificate_params)
  #     if @person_certificate.save
  #       return_the @person_certificate.certificate, handler: tpl_handler
  #     else
  #       render_422(_("Something went wrong."))
  #     end
  #   else
  #     if @person_certificate.full_name.blank?
  #       @person_certificate.assign_attributes(person_certificate_params)
  #       @person_certificate.issued_date = DateTime.now if @person_certificate.issued_date.empty?
  #       @person_certificate.write_files
  #       return_the @person_certificate.reload.certificate, handler: "jb"
  #     else
  #       render_422(_("User already completed the full name"))
  #     end
  #   end
  # end

  def show
    @person_certificate = PersonCertificate.where(unique_id: params[:unique_id]).first!
    render :show, handler: tpl_handler
  end

  protected

  def tpl_handler
    :jb
  end

  def person_certificate_params
    params.require(:person_certificate).permit(%i[ certificate_id purchased_order_id amount_paid currency purchased_sku purchased_platform receipt_id full_name ])
  end
end
