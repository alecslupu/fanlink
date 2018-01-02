class Message < ApplicationRecord

  belongs_to :person
  belongs_to :room

  scope :visible, -> { where(hidden: false) }
end