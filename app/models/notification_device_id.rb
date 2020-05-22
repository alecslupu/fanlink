# frozen_string_literal: true
# == Schema Information
#
# Table name: notification_device_ids
#
#  id                :bigint(8)        not null, primary key
#  person_id         :integer          not null
#  device_identifier :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  device_type       :integer          default("unknown"), not null
#  not_registered    :boolean          default(FALSE), not null
#

class NotificationDeviceId < ApplicationRecord
  belongs_to :person

  enum device_type: { unknown: 0, android: 1, ios: 2, web: 3 }
  has_paper_trail ignore: [:created_at, :updated_at]

  # validates :device_type, presence: { message: _("Device type is not present.") }

  validates :device_identifier,
            uniqueness: { message: _("That device id is already registered.") },
            presence: { message: _("Device identifier is required.") }

end
