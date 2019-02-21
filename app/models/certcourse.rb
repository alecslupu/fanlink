class Certcourse < ApplicationRecord
  has_many :certificate_certcourses
  has_many :certificates, through: :certificate_certcourses, dependent: :destroy

  enum status: %i[entry live]
end
