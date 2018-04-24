class MessageMention < ApplicationRecord
  validates :person_id, presence: true
end
