class PersonInterest < ApplicationRecord
  belongs_to :interest
  belongs_to :person, touch: true
  validates_uniqueness_of :interest_id, :scope => :person_id

end
