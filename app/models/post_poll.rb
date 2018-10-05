class PostPoll < ApplicationRecord
	belongs_to :post 

	has_many :post_poll_options
end
