# == Schema Information
#
# Table name: person_certificates
#
#  id                                    :bigint(8)        not null, primary key
#  person_id                             :integer          not null
#  certificate_id                        :integer          not null
#  full_name                             :string           default(""), not null
#  issued_date                           :datetime
#  validity_duration                     :integer          default(0), not null
#  amount_paid                           :bigint(8)        default(0), not null
#  currency                              :string           default(""), not null
#  fee_waived                            :boolean          default(FALSE)
#  purchased_waived_date                 :datetime
#  access_duration                       :integer          default(0), not null
#  purchased_order_id                    :string
#  purchased_platform                    :integer          default("ios"), not null
#  purchased_sku                         :string
#  unique_id                             :string
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  issued_certificate_image_file_name    :string
#  issued_certificate_image_content_type :string
#  issued_certificate_image_file_size    :integer
#  issued_certificate_image_updated_at   :datetime
#  issued_certificate_pdf_file_name      :string
#  issued_certificate_pdf_content_type   :string
#  issued_certificate_pdf_file_size      :integer
#  issued_certificate_pdf_updated_at     :datetime
#  receipt_id                            :string
#  is_completed                          :boolean          default(FALSE)
#

class PersonCertificate < ApplicationRecord
  include AttachmentSupport

  has_course_image_called :issued_certificate_image
  has_pdf_file_called :issued_certificate_pdf

  belongs_to :person, touch: true
  belongs_to :certificate, touch: true
  validates_uniqueness_of :certificate_id, scope: :person_id

  enum purchased_platform: %i[ios android]

  scope :for_person, -> (person) { where(person_id: person.id) }
  scope :for_android, -> (person) { where(person_id: person.id, purchased_platform: "android") }
  scope :for_ios, -> (person) { where(person_id: person.id, purchased_platform: "ios") }

  def product
    Product.find(14)
  end

  include Magick


  def self.update_certification_status(certificate_ids, user_id)
    # TODO find a better way to write this
    # TODO move it in a job
    where(person_id: user_id, certificate_id: certificate_ids).find_each do |c|
      person_certcourses = PersonCertcourse.where(person_id: user_id, certcourse_id: c.certificate.certcourse_ids).pluck(:is_completed)
      # raise ({c_size: c.certificate.certcourse_ids.size, p_size: person_certcourses.size, pc: person_certcourses}).inspect
      c.is_completed = (c.certificate.certcourses.size == person_certcourses.size) && person_certcourses.inject(true, :&)
      c.save!
    end
  end

  def write_files
    require "rmagick"
    require "prawn"

    img = ImageList.new(Paperclip.io_adapters.for(certificate.template_image).path)

    txt = Draw.new

    img.annotate(txt, 0, 0, 0, -100, full_name) {
      txt.gravity = Magick::CenterGravity
      txt.pointsize = 100
      txt.stroke = "#FFFFFF"
      txt.fill = "#000000"
      txt.font_weight = Magick::BoldWeight
    }
    img.format = "jpeg"

    jpeg_file = Tempfile.new(%w(certificate_image .jpg))
    pdf_file =  Tempfile.new(%w(certificate_image .pdf))


    img[0].write(jpeg_file.path)

    Prawn::Document.generate(pdf_file.path, page_layout: :landscape) do |pdf|
      pdf.image jpeg_file.path, fit: [pdf.bounds.right, pdf.bounds.top]
    end

    self.update_attributes(issued_certificate_image: jpeg_file, issued_certificate_pdf: pdf_file)
  end
end
