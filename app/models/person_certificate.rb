class PersonCertificate < ApplicationRecord
  belongs_to :person
  belongs_to :certificate
  validates_uniqueness_of :certificate_id, :scope => :person_id
end
