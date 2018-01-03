class Message < ApplicationRecord

  belongs_to :person
  belongs_to :room

  validates :body, presence: { message: "Message body is required" }
  scope :visible, -> { where(hidden: false) }
end