class Post < ApplicationRecord
  enum status: %i[ pending published deleted rejected ]

  belongs_to :person

  validate :sensible_dates
  validates :body, presence: { message: "Message body is required" }

  scope :following, -> (follower) { includes(:person).where(person: follower.following) }

  scope :in_date_range, -> (start_date, end_date) {
                               where("posts.created_at >= ? and posts.created_at <= ?",
                               start_date.beginning_of_day, end_date.end_of_day)
                            }

  scope :visible, -> { published.where("(starts_at IS NULL or starts_at < ?) and (ends_at IS NULL or ends_at > ?)",
                                               Time.zone.now, Time.zone.now) }

private

  def sensible_dates
    if starts_at.present? && ends_at.present? && starts_at > ends_at
      errors.add(:starts_at, "Cannot start after end!")
    end
  end
end
