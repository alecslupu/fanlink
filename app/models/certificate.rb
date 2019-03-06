class Certificate < ApplicationRecord
  belongs_to :room, optional: true

  has_many :certificate_certcourses
  has_many :certcourses, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certificates
  has_many :people, through: :person_certificates, dependent: :destroy

  enum status: %i[entry live]
  validates :long_name, :short_name, :description, :certificate_order, :status, :sku_ios, :sku_android, :validity_duration, :access_duration, presence: true
end
