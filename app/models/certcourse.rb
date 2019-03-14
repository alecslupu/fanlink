class Certcourse < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  has_many :certificate_certcourses
  has_many :certificates, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certcourses
  has_many :people, through: :person_certcourses, dependent: :destroy

  has_many :certcourse_pages

  enum status: %i[entry live]

  validates :long_name, :short_name, :description, :color_hex, :status, :duration, :copyright_text, presence: true
  validates_format_of :color_hex, with: /\A#(?:[A-F0-9]{3}){1,2}\z/i

  scope :live_status, -> { where(status: "live") }
end
