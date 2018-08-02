class RoomMembership < ApplicationRecord
  belongs_to :person, required: true, touch: true
  belongs_to :room, required: true

  validates :person_id, uniqueness: { scope: :room_id }

  validate :check_private

  before_destroy :check_created_by


private

  def check_created_by
    if person_id == room.created_by_id
      errors.add(:person_id, "Room creator cannot be deleted.")
      throw :abort
    end
  end

  def check_private
    if room.public
      errors.add(:room_id, "Public room cannot have members.")
    end
  end
end
