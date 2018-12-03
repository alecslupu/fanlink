class Semester < ApplicationRecord
  acts_as_tenant(:product)

  belongs_to :product

  has_many :courses, -> { order(created_at: :asc) }

  validates :name, presence: { message: _("A name is required.") }
  validates :description, presence: { message: _("A description is required.") }
  validates :start_date, presence: { message: _("A start date is required.") }

  validates :name, uniqueness: { scope: :product_id, message: _("A semester with that name already exists.") }

  validates :name, length: { in: 3..26, message: _("Name must be between 3 and 26 characters.") }
  validates :description, length: { in: 3..500, message: _("Description must be between 3 and 500 characters.") }

  validate :sensible_dates

  scope :available, -> {
    where("(start_date < ?) and (end_date IS NULL or end_date > ?)",
                    Time.zone.now, Time.zone.now)
  }

private

  def sensible_dates
    if end_date.present? && end_date < start_date
      errors.add(:end_date, :sensible_dates, message: _("End date cannot be after start date."))
    end
  end
end
