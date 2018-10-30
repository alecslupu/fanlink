class Poll < ApplicationRecord
  enum poll_type: %i[ post ]
  enum poll_status: %i[ active disabled ]

  belongs_to :post, foreign_key: "poll_type_id", foreign_type: "poll_type"
  has_many :poll_options
end
