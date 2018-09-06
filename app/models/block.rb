class Block < ApplicationRecord
  belongs_to :blocker, class_name: "Person", touch: true
  belongs_to :blocked, class_name: "Person", touch: true

  validates :blocked_id, uniqueness: { scope: :blocker_id, message: _("That user is already blocked.") }
end
