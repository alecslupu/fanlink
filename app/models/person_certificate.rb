class PersonCertificate < ApplicationRecord
  include AttachmentSupport

  has_course_image_called :issued_certificate_image
  has_pdf_file_called :issued_certificate_pdf

  belongs_to :person, touch: true
  belongs_to :certificate, touch: true
  validates_uniqueness_of :certificate_id, scope: :person_id

  enum purchased_platform: %i[ios android]

  scope :for_person, -> (person) {where(person_id: person.id)}
  scope :for_android, -> (person) {where(person_id: person.id, purchased_platform: "android")}
  scope :for_ios, -> (person) {where(person_id: person.id, purchased_platform: "ios")}

  def product
    Product.find(14)
  end

  include Magick

  def write_files
    require 'rmagick'
    require 'prawn'

    img = ImageList.new(Paperclip.io_adapters.for(certificate.template_image).path)

    txt = Draw.new

    img.annotate(txt, 0,0,0,-100, full_name){
      txt.gravity = Magick::CenterGravity
      txt.pointsize = 100
      txt.stroke = '#FFFFFF'
      txt.fill = '#000000'
      txt.font_weight = Magick::BoldWeight
    }
    img.format = 'jpeg'

    jpeg_file = Tempfile.new(%w(certificate_image .jpg))
    pdf_file =  Tempfile.new(%w(certificate_image .pdf))


    img[0].write(jpeg_file.path)

    Prawn::Document.generate(pdf_file.path, :page_layout => :landscape) do |pdf|
      pdf.image jpeg_file.path, :fit => [pdf.bounds.right, pdf.bounds.top]
    end

    self.update_attributes(issued_certificate_image: jpeg_file,issued_certificate_pdf: pdf_file)
  end
end
