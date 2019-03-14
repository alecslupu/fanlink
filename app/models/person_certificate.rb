class PersonCertificate < ApplicationRecord
  include AttachmentSupport

  has_image_called :issued_certificate_image
  has_image_called :issued_certificate_pdf

  belongs_to :person, touch: true
  belongs_to :certificate, touch: true
  validates_uniqueness_of :certificate_id, :scope => :person_id

  enum purchased_platform: %i[ios android]

  scope :for_person, -> (person) {where(person_id: person.id)}
  scope :for_android, -> (person) {where(person_id: person.id, purchased_platform: "android")}
  scope :for_ios, -> (person) {where(person_id: person.id, purchased_platform: "ios")}
end
