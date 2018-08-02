class NotificationDeviceId < ApplicationRecord
  belongs_to :person, touch: true

  validates :device_identifier,
            uniqueness: { message: "That device id is already registered." },
            presence: true
end
