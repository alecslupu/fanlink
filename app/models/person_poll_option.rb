class PersonPollOption < ApplicationRecord
  belongs_to :poll_option
  belongs_to :person
end