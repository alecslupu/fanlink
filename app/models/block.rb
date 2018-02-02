class Block < ApplicationRecord
  belongs_to :blocker, class_name: "Person"
  belongs_to :blocked, class_name: "Person"

  validates :blocked_id, uniqueness: { scope: :blocker_id, message: "That user is already blocked." }
end
