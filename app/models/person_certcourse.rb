class PersonCertcourse < ApplicationRecord
  belongs_to :person
  belongs_to :certcourse
  validates_uniqueness_of :certcourse_id, :scope => :person_id
  
  scope :for_person, -> (person) {where(person_id: person.id)}
end
