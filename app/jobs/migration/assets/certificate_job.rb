module Migration
  module Assets
    class CertificateJob < ::Migration::Assets::ApplicationJob

      def perform(certificate_id)
        require 'open-uri'
        certificate = ::Certificate.find(certificate_id)
        url = paperclip_asset_url(certificate, "template_image", certificate.product)
        certificate.template_image.attach(
          io: open(url),
          filename: certificate.template_image_file_name,
          content_type: certificate.template_image_content_type
        )
      end
    end
  end
end
