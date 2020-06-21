# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id          :bigint(8)        not null, primary key
#  semester_id :integer          not null
#  name        :text             not null
#  description :text             not null
#  start_date  :datetime         not null
#  end_date    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE)
#

class Course < ApplicationRecord
  belongs_to :semester
  has_paper_trail ignore: [:created_at, :updated_at]


  has_many :lessons, -> { order(created_at: :asc) }

  validates :name, presence: { message: _("A name is required.") }
  validates :description, presence: { message: _("A description is required.") }
  validates :start_date, presence: { message: _("A start date is required.") }

  validates :name, uniqueness: { scope: :semester_id, message: _("A class with that name already exists for this semester.") }

  validates :name, length: { in: 3..26, message: _("Name must be between 3 and 26 characters") }
  validates :description, length: { in: 3..500, message: _("Description must be between 3 and 500 characters.") }

  validate :sensible_dates

  scope :available, -> {
    where("(start_date < ?) and (end_date IS NULL or end_date > ?)",
                    Time.zone.now, Time.zone.now)
  }

private

  def sensible_dates
    if end_date.present? && start_date > end_date
      errors.add(:start_date, :sensible_dates, message: _("Start date cannot be after end date."))
    end

    if end_date.present? && end_date < start_date
      errors.add(:end_date, :sensible_dates, message: _("End date cannot be after start date."))
    end
  end
end
