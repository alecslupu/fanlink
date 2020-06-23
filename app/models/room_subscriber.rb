# frozen_string_literal: true

class RoomSubscriber < ApplicationRecord
  belongs_to :room
  belongs_to :person
  belongs_to :last_message, class_name: 'Message', optional: true

  validate :check_private

  validates_uniqueness_of :person_id, scope: :room_id

  before_create :set_last_notification_time

  scope :for_product, ->(product) { joins(:person).where( people: { product_id: product.id }) }

  private

    def check_private
      errors.add(:room_id, :not_public, message: _('must be public to have owners.')) if room.private?
    end

    def set_last_notification_time
      self.last_notification_time = DateTime.now - 2.minutes
    end
end
