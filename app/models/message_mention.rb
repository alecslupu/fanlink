class MessageMention < ApplicationRecord
  validates :person_id, presence: true

  belongs_to :message
  belongs_to :person
end
