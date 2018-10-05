class PostPollOption < ApplicationRecord
	belongs_to :post_poll

	has_and_belongs_to_many :persons
end
