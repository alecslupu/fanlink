# frozen_string_literal: true

# == Schema Information
#
# Table name: room_memberships
#
#  id            :bigint(8)        not null, primary key
#  room_id       :integer          not null
#  person_id     :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  message_count :integer          default(0), not null
#

class RoomMembership < ApplicationRecord
  belongs_to :person, required: true, touch: true
  belongs_to :room, required: true

  validates :person_id, uniqueness: { scope: :room_id, message: _("You are already a member of this room.") }

  validate :check_private

  before_destroy :check_created_by


private

  def check_created_by
    if person_id == room.created_by_id
      errors.add(:person_id, :check_created_by, message: _("Room creator cannot be deleted."))
      throw :abort
    end
  end

  def check_private
    if room.public
      errors.add(:room_id, :check_private, message: _("Public room cannot have members."))
    end
  end
end
