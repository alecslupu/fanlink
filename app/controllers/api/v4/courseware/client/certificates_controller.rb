class Api::V4::Courseware::Client::CertificatesController < ApiController

  # o sa dai certificarile persoane cu id-ul params[:person_id]
  # PersonCertificate.last.issued_certificate_image.url poza

  def index
    id = Certificate.last.nil? ? 1 : Certificate.last.id
    @certificates = [
      Certificate.create(
        id: id + 1,
        long_name: "First Certificate Test",
        short_name: "1st Cert Test",
        description: "This is the first certificate ever created",
        certificate_order: 1,
        color_hex: "#000000",
        status: "entry",
        room_id: nil,
        is_free: false,
        sku_ios: "com.musicto.fanlink.caned.demo_nevada_dispensary_education",
        sku_android: "1111",
        validity_duration: 1000000,
        access_duration: 1000000,
        certificate_issuable: false,
        created_at: DateTime.parse("Thu, 21 Feb 2019 15 :14:58 UTC +00:00"),
        updated_at: DateTime.parse("Mon, 11 Mar 2019 14 :02:52 UTC +00:00"),
        template_image_file_name: "Certificate_-_V1.jpg",
        template_image_content_type: "image/jpeg",
        template_image_file_size: 679079,
        template_image_updated_at: DateTime.parse("Mon, 11 Mar 2019 14 :02:49 UTC +00:00"),
        product_id: current_user.product.id
      )
    ]
    @certificates <<
      Certificate.create(
        id: id + 2,
        long_name: "Not bought certificate",
        short_name: "Nbgtcrt",
        description: "I didn't buy this",
        certificate_order: 3,
        color_hex: "#0000FF",
        status: "entry",
        room_id: 1491,
        is_free: true,
        sku_ios: "skuios",
        sku_android: "skuandroid",
        validity_duration: 10000,
        access_duration: 100000,
        certificate_issuable: true,
        created_at: DateTime.parse("Fri, 22 Feb 2019 11:12:48 UTC +00:00"),
        updated_at: DateTime.parse("Wed, 13 Mar 2019 10:09:18 UTC +00:00"),
        template_image_file_name: nil,
        template_image_content_type: nil,
        template_image_file_size: nil,
        template_image_updated_at: nil,
        product_id: current_user.product.id
      )
      return_the @certificates, handler: :jb
  end

  def download
    @url = "https://s3.us-east-1.amazonaws.com/fanlink-staging/caned/certificates/template_images/000/000/086/original/76ba71377a4b46a2d2c72921c0e62bc3b3b9d6cf.jpg?1571836879"
  end
end
