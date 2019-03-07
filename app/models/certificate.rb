class Certificate < ApplicationRecord
  include AttachmentSupport

  has_image_called :template_image
  
  belongs_to :room, optional: true

  has_many :certificate_certcourses
  has_many :certcourses, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certificates
  has_many :people, through: :person_certificates, dependent: :destroy

  validates_uniqueness_of :certificate_order

  enum status: %i[entry live]

  scope :live_status, -> {where(status: "live")}

  def product
  	Product.find_by(internal_name: "cannapp")
  end
end
