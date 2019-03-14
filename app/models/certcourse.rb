class Certcourse < ApplicationRecord
  has_many :certificate_certcourses
  has_many :certificates, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certcourses
  has_many :people, through: :person_certcourses, dependent: :destroy

  has_many :certcourse_pages

  validates_format_of :color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i

  enum status: %i[entry live]

  scope :live_status, -> {where(status: "live")}
end
