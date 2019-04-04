class EventCheckin < ApplicationRecord
  belongs_to :event
  belongs_to :person, touch: true

  validates_uniqueness_of :event_id, scope: :person_id

  validate :product_match
  def product_match
    errors.add(:base, "Event not available for you to check in") unless event.product_id == person.product_id
  end
end
