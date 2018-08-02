class MessageMention < ApplicationRecord
  validates :person_id, presence: true

  belongs_to :message, touch: true
  belongs_to :person, touch: true
end
