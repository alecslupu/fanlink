class Post < ApplicationRecord
  enum status: %i[ hidden published expired rejected ]

  belongs_to :person

  validate :sensible_dates
  validates :body, presence: { message: "Message body is required" }

private

  def sensible_dates
    if starts_at.present? && ends_at.present?
      errors.add(:starts_at, "Cannot start after end!")
    end
  end

end
