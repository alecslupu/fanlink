class NotificationDeviceId < ApplicationRecord
  belongs_to :person

  enum device_type: { unknown: 0, android: 1, ios: 2, web: 3 }

  validates :device_type, presence: { message: _("Device type is not present.") }

  validates :device_identifier,
            uniqueness: { message: _("That device id is already registered.") },
            presence: { message: _("Device identifier is required.")}
end
