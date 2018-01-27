class Relationship < ApplicationRecord
  enum status: %i[ requested friended denied withdrawn unfriended ]

  STATUS_TRANSITIONS = {
      requested: %i[ friended denied withdrawn ],
      friended: %i[ unfriended ],
      denied: [],
      withdrawn: [],
      unfriended: []
  }

  VISIBLE_STATUSES = %i[ requested friended ]

  before_create :check_outstanding

  belongs_to :requested_by, class_name: "Person"
  belongs_to :requested_to, class_name: "Person"

  validate :check_outstanding
  validate :check_non_self
  validate :valid_status_transition

  scope :pending_to_person, -> (person) { where(status: :requested).where(requested_to: person) }
  scope :for_people, -> (person1, person2, limit=1) { where(requested_to: [person1, person2]).where(requested_by: [person1, person2]).order(updated_at: :desc).limit(limit) }
  scope :for_person, -> (person) { where(requested_to: person).or(where(requested_by: person)) }
  scope :visible, -> { where(status: VISIBLE_STATUSES) }

  def self.counted_transition?(before)
    before == :requested
  end

  def person_involved?(person)
    requested_to == person || requested_by == person
  end

private

  def check_non_self
    if requested_by_id == requested_to_id
      errors.add(:base, "You cannot have a relationship with yourself")
    end
  end

  def check_outstanding
    if requested? && Relationship.where.not(id: id).where(requested_by_id: [requested_by_id, requested_to_id]).
                  where(requested_to_id: [requested_to_id, requested_by_id]).
                  where(status: %i[ requested friended ]).exists?
      errors.add(:base, "You already have an existing friendship or friend request to or from that person")
    end
  end

  def valid_status_transition
    if status_changed? && !(STATUS_TRANSITIONS[status_was.to_sym].include?(status.to_sym))
      errors.add(:status, "Sorry, we cannot grant your request at this time.")
    end
  end
end
