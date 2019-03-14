class Certificate < ApplicationRecord
  include AttachmentSupport

  has_image_called :template_image

  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :room, optional: true

  has_many :certificate_certcourses
  has_many :certcourses, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certificates
  has_many :people, through: :person_certificates, dependent: :destroy

  validates_uniqueness_to_tenant :certificate_order
  validates_attachment_presence :template_image

  enum status: %i[entry live]
  validates :long_name, :short_name, :description, :certificate_order, :status, :sku_ios, :sku_android, :validity_duration, :access_duration, presence: true

  scope :live_status, -> { where(status: "live") }
end
