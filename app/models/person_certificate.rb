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
  has_paper_trail

  include AttachmentSupport

  has_course_image_called :issued_certificate_image
  has_pdf_file_called :issued_certificate_pdf

  belongs_to :person, touch: true
  belongs_to :certificate, touch: true
  validates_uniqueness_of :certificate_id, scope: :person_id

  validates :amount_paid, numericality: { greater_than_or_equal_to: 0 }

  enum purchased_platform: %i[ios android]

  scope :for_person, -> (person) { where(person_id: person.id) }
  scope :for_android, -> (person) { where(person_id: person.id, purchased_platform: "android") }
  scope :for_ios, -> (person) { where(person_id: person.id, purchased_platform: "ios") }
  scope :for_product, -> (product) { joins(:person).where(people: { product_id: product.id } ) }

  scope :free, -> { joins(:certificate).where(certificates: { is_free: true } ) }
  scope :paid, -> { joins(:certificate).where(certificates: { is_free: false } ) }

  def product
    person.product
  end

  before_create do
    self.generate_token!
    self.access_duration   = self.certificate.access_duration
    self.validity_duration = self.certificate.validity_duration
  end

  def self.update_certification_status(certificate_ids, user_id)
    # TODO find a better way to write this
    # TODO move it in a job
    where(person_id: user_id, certificate_id: certificate_ids).find_each do |person_certificate|
      next if person_certificate.is_completed?
      certcouse_ids = person_certificate.certificate.certcourses.live_status.pluck(:id)
      person_certcourses = PersonCertcourse.where(person_id: user_id, certcourse_id: certcouse_ids ).pluck(:is_completed)
      # raise ({c_size: c.certificate.certcourse_ids.size, p_size: person_certcourses.size, pc: person_certcourses}).inspect
      person_certificate.is_completed = (certcouse_ids.size == person_certcourses.size) && person_certcourses.inject(true, :&)
      person_certificate.save!
    end
  end

  def generate_token!(attempts = 0)
    raise "Could not acquire a unique id after 10 attempts" if attempts == 10
    charlist = "A".upto("Z").to_a + 0.upto(9).to_a.map(&:to_s) - %w(L O 0 1 Z 2)
    self.unique_id = 10.times.collect { charlist.sample }.join
    token_exists = self.class.where(unique_id: unique_id).exists?
    generate_token! 1+attempts if token_exists
  end

  def write_files
    require "prawn"

    img = MiniMagick::Image.open(Paperclip.io_adapters.for(certificate.template_image).path)

    img.combine_options do |txt|
      txt.gravity "Center"
      txt.fill("#000000")
      txt.draw ''
      txt.pointsize 100
      txt.draw "text 0,-250 '#{full_name}'"
      txt.weight 700
      txt.stroke "#FFFFFF"
    end

    img.combine_options do |txt|
      txt.gravity "SouthEast"
      txt.fill("#4d4d4d")
      txt.draw ''
      txt.pointsize 50
      txt.draw "text 200, 200 'https://can-ed.com/certificate-check/#{unique_id}'"
      txt.weight 700
      txt.stroke "#FFFFFF"
    end

    completed_date = (issued_date.to_datetime rescue DateTime.now ).strftime("%B %d, %Y")

    img.combine_options do |txt|
      txt.gravity "NorthEast"
      txt.fill("#4d4d4d")
      txt.draw ''
      txt.pointsize 60
      txt.draw "text 480, 250 '#{completed_date}'"
      txt.weight 700
      txt.stroke  "#FFFFFF"
    end
    img.format "jpeg"

    jpeg_file = Tempfile.new(%w(certificate_image .jpg))

    img.write(jpeg_file.path)

    pdf_file =  Tempfile.new(%w(certificate_image .pdf))
    Prawn::Document.generate(pdf_file.path, page_layout: :landscape) do |pdf|
      pdf.image jpeg_file.path, fit: [pdf.bounds.right, pdf.bounds.top]
    end

    self.update_attributes(issued_date: issued_date , issued_certificate_image: jpeg_file, issued_certificate_pdf: pdf_file)
  end
end
