class PollOption < ApplicationRecord
	belongs_to :poll

	has_many :person_poll_options
	has_many :people, through: :person_poll_options

	def votes
	  PersonPollOption.where(poll_option_id: self.id).count
	end
end
