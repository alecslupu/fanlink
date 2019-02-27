class Certificate < ApplicationRecord
  belongs_to :room

  has_many :certificate_certcourses
  has_many :certcourses, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certificates
  has_many :people, through: :person_certificates, dependent: :destroy

  enum status: %i[entry live]

end
