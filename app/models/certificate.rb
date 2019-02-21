class Certificate < ApplicationRecord
  belongs_to :room

  has_many :certificate_certcourses
  has_many :certcourses, through: :certificate_certcourses, dependent: :destroy

  enum status: %i[entry live]
end
