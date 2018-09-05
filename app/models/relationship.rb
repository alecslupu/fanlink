class Relationship < ApplicationRecord
  include Relationship::RealTime
  enum status: %i[ requested friended ]

  has_paper_trail

  belongs_to :requested_by, class_name: "Person", touch: true
  belongs_to :requested_to, class_name: "Person"

  validate :check_outstanding
  validate :check_non_self
  validate :valid_status_transition

  scope :pending_to_person, -> (person) { where(status: :requested).where(requested_to: person) }
  scope :for_people, -> (person1, person2) { where(requested_to: [person1, person2]).where(requested_by: [person1, person2]) }
  scope :for_person, -> (person) { where(requested_to: person).or(where(requested_by: person)) }

  def person_involved?(person)
    requested_to == person || requested_by == person
  end

private

  def check_non_self
    if requested_by_id == requested_to_id
      errors.add(:base, _("You cannot have a relationship with yourself."))
    end
  end

  def check_outstanding
    if requested? && Relationship.where.not(id: id).for_people(requested_by, requested_to).exists?
      errors.add(:base, _("You already have an existing friendship or friend request to or from that person."))
    end
  end

  def valid_status_transition
    if status_changed?
      if status_was.to_sym == :friended && self.requested?
        errors.add(:status, _("You cannot change from friended to requested."))
      end
    end
  end
end
