class Poll < ApplicationRecord
  enum poll_type: %i[ post ]
  enum poll_status: %i[ inactive active disabled]

  belongs_to :post, foreign_key: "poll_type_id", foreign_type: "poll_type"
  has_many :poll_options

  validate :start_date_cannot_be_in_the_past

  def start_date_cannot_be_in_the_past
  	if start_date.present? && start_date < Date.today
  	  errors.add(:expiration_date, "can't be in the past")	
  	end
  end
end
