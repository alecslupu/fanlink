class Certificate < ApplicationRecord
  include AttachmentSupport

  has_file_called :pdf
  
  belongs_to :room, optional: true

  has_many :certificate_certcourses
  has_many :certcourses, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certificates
  has_many :people, through: :person_certificates, dependent: :destroy

  enum status: %i[entry live]

  scope :live_status, -> {where(status: "live")}

end
