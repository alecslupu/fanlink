class PersonCertcourse < ApplicationRecord
  belongs_to :person
  belongs_to :certcourse
  validates_uniqueness_of :certcourse_id, :scope => :person_id
end
