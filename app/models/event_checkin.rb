class EventCheckin < ApplicationRecord
  belongs_to :event
  belongs_to :person, touch: true
  validates_uniqueness_of :event_id, :scope => :person_id
  validate :product_match

  def product_match
    # puts "Trying"
    if event.product_id != person.product_id
      errors.add(:base, "Event not available for you to check in")
    end
  end
end
