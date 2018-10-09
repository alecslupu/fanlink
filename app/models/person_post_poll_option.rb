class PersonPostPollOption < ApplicationRecord
  belongs_to :post_poll_option
  belongs_to :person
end
