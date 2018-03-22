class Event < ApplicationRecord
  has_paper_trail

  acts_as_tenant(:product)

  normalize_attributes :place_identifier

  validate :date_sanity
  validates :name, presence: { message: "Name is required" }
  validates :starts_at, presence: { message: "Starts at is required" }

  scope :in_date_range, -> (from, to) {
    where("events.starts_at >= ? and events.starts_at <= ?",
          from.beginning_of_day, to.end_of_day)
  }

  def place_info
    info = nil
    if self.place_identifier.present?
      client = GooglePlaces::Client.new(ENV["GOOGLE_PLACES_KEY"])
      info = client.spot(self.place_identifier)
    end
    info
  rescue GooglePlaces::InvalidRequestError
    info
  end

private

  def date_sanity
    if ends_at.present? && ends_at < starts_at
      errors.add(:ends_at, "cannot be before starts at.")
    end
  end
end
