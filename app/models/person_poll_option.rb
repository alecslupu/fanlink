class PersonPollOption < ApplicationRecord
  belongs_to :poll_option
  belongs_to :person
  validates_uniqueness_of :poll_option_id, :scope => :person_id
end

