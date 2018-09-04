class NotificationDeviceId < ApplicationRecord
  belongs_to :person

  validates :device_identifier,
            presence: true
end
