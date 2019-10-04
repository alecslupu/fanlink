# == Schema Information
#
# Table name: polls
#
#  id           :bigint(8)        not null, primary key
#  poll_type    :integer
#  poll_type_id :integer
#  start_date   :datetime         not null
#  duration     :integer          default(0), not null
#  end_date     :datetime         default(Thu, 07 Feb 2019 01:46:08 UTC +00:00)
#  poll_status  :integer          default("inactive"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  description  :jsonb            not null
#  product_id   :integer          not null
#

class Poll < ApplicationRecord
  include TranslationThings

  # after_initialize do
  #   self.end_date = Time.zone.now + 1.month
  # end

  enum poll_type: %i[ post ]
  enum poll_status: %i[ inactive active disabled ]

  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :post, foreign_key: "poll_type_id", foreign_type: "poll_type", optional: true
  has_many :poll_options, dependent: :destroy

  validate :start_date_cannot_be_in_the_past
  validate :description_cannot_be_empty

  validates :duration, numericality: {
    greater_than: 0,
    message: "Duration cannot be 0, please specify duration or end date of the poll"
  }

  validates_uniqueness_of :poll_type_id, scope: :poll_type, message: "has already been used on that Post. Check Post id"

  before_validation :add_end_date

  has_manual_translated :description

  accepts_nested_attributes_for :poll_options, allow_destroy: true

  scope :assignable, -> {
          where(poll_type_id: nil).where("end_date > ?", Time.now)
        }

  def closed?
    end_date.to_time.to_i <= Time.now.to_time.to_i
  end

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Time.now
      errors.add(:expiration_date, "poll can't start in the past")
    end
  end

  def description_cannot_be_empty
    if !description.present? || description.empty?
      errors.add(:description_error, "description can't be empty")
    end
  end

  def was_voted(person_id)
    PersonPollOption.where(person_id: person_id, poll_option_id: poll_option_ids).count > 0
  end

  private
    def add_end_date
      if duration.zero?
        self.duration = end_date.to_datetime.to_i - start_date.to_datetime.to_i
      else
        self.end_date = start_date.to_datetime + duration.seconds
      end
    end
end
