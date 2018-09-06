class NotificationDeviceId < ApplicationRecord
  belongs_to :person

  validates :device_identifier,
            uniqueness: { message: _("That device id is already registered.") },
            presence: { message: _("Device identifier is required.")}
end
