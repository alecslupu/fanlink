class PersonCertificate < ApplicationRecord
  include AttachmentSupport

  has_image_called :picture
  has_file_called :pdf

  belongs_to :person
  belongs_to :certificate
  validates_uniqueness_of :certificate_id, :scope => :person_id

  enum purchased_platform: %i[ios android]

  scope :for_user, -> (person) {where(person_id: person.id)}
  scope :for_android, -> (person) {find_by(person_id: person.id, purchased_platform: "android")}
  scope :for_ios, -> (person) {find_by(person_id: person.id, purchased_platform: "ios")}
end
