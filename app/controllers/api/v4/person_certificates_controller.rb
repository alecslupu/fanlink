class Api::V4::PersonCertificatesController < ApiController
  require 'rmagick'
  include Magick

  load_up_the Certificate, from: :certificate_id

  def create
    @person_certificate = PersonCertificate.find_by(certificate_id: params[:certificate_id],person_id: @current_user.id)
    if @person_certificate
      if @person_certificate.full_name.blank?
        @person_certificate.update_attributes(person_certificate_params)
        save_edited_files_to_paperclip(@person_certificate,@certificate)
        @person_certificate.issued_certificate_image = @certificate.template_image
        @person_certificate.save
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

  def save_edited_files_to_paperclip(person_certificate, certificate)
    full_name = person_certificate.full_name
    image = ImageList.new(Paperclip.io_adapters.for(certificate.template_image).path)
    canvas = ImageList.new
    text = Draw.new
    canvas.new_image(3840,2160,Magick::TextureFill.new(image))
    text.annotate(canvas,0,0,1200,1400, full_name){self.pointsize = 100}
    jpeg_file = Tempfile.new(['certificate_image','.jpg'])
    canvas.write(jpeg_file.path)
    #pdf_file = Tempfile.new(['certificate_pdf','.pdf'])
    #canvas.write(pdf_file.path)
    person_certificate.update_attributes(issued_certificate_image: jpeg_file)#,issued_certificate_pdf: pdf_file)
  end

  def person_certificate_params
    params.require(:person_certificate).permit(%i[ certificate_id purchased_order_id amount_paid currency purchased_sku purchased_platform receipt_id full_name ])
  end
end