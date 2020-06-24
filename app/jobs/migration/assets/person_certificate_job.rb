module Migration
  module Assets
    class PersonCertificateJob < ::Migration::Assets::ApplicationJob
      def perform(post_id, what)
        require 'open-uri'
        post = ::PersonCertificate.find(post_id)

        url = paperclip_asset_url(post, what, post.product)
        case what
        when 'issued_certificate_image'
          post.issued_certificate_image.attach(io: open(url),
                                               filename: post.issued_certificate_image_file_name,
                                               content_type: post.issued_certificate_image_content_type)
        when 'issued_certificate_pdf'
          post.issued_certificate_pdf.attach(io: open(url),
                                             filename: post.issued_certificate_pdf_file_name,
                                             content_type: post.issued_certificate_pdf_content_type)
        end
      end
    end

  end
end
