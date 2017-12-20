class RoomMembership < ApplicationRecord
  belongs_to :person, required: true
  belongs_to :room, required: true
end
