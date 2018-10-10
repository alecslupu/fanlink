class PostPollOption < ApplicationRecord
	belongs_to :post_poll

	has_many :person_post_poll_options
	has_many :people, through: :person_post_poll_options
end
