class PostPoll < ApplicationRecord
  belongs_to :post
  belongs_to :poll
end
