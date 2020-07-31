# frozen_string_literal: true

# == Schema Information
#
# Table name: event_checkins
#
#  id         :bigint           not null, primary key
#  event_id   :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventCheckin < ApplicationRecord
  belongs_to :event
  belongs_to :person, touch: true

  validates :event_id, uniqueness: { scope: :person_id }

  validate :product_match
  def product_match
    errors.add(:base, 'Event not available for you to check in') unless event.product_id == person.product_id
  end
end
