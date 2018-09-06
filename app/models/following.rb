class Following < ApplicationRecord
  belongs_to :follower, class_name: "Person", touch: true
  belongs_to :followed, class_name: "Person", touch: true

  validates :followed_id, uniqueness: { scope: :follower_id, message: _("You are already following that person.") }
end
