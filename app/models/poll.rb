class Poll < ApplicationRecord
  enum poll_type: %i[ post ]
  enum poll_status: %i[ inactive active disabled ]

  belongs_to :post, foreign_key: "poll_type_id", foreign_type: "poll_type"
  has_many :poll_options, dependent: :destroy

  validate :start_date_cannot_be_in_the_past

  before_validation :add_end_date

  def closed?
    start_date.beginning_of_day.to_time.to_i + duration <= Date.today.end_of_day.to_time.to_i
  end

  def start_date_cannot_be_in_the_past
  	if start_date.present? && start_date < Date.today
  	  errors.add(:expiration_date, "can't be in the past")	
  	end
  end

  def was_voted(person_id)
    self.poll_options.each do |po|
      if PersonPollOption.find_by(person_id: person_id, poll_option_id: po.id)
        return true
      end
    end
    return false
  end

  private

  def add_end_date
    self.end_date = start_date.to_datetime + duration.seconds/1000
  end
end
